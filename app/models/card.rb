class Card < ApplicationRecord
  include Discard::Model
  include PgSearch::Model

  belongs_to :column
  belongs_to :user
  belongs_to :assignee, class_name: "User", foreign_key: "assignee_id", optional: true
  has_many :comments, dependent: :destroy
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :likes, as: :likable, dependent: :destroy
  validates :title, length: { within: 2..50 }
  validates :position, uniqueness: { scope: :column }

  # ActionText
  has_rich_text :body

  acts_as_taggable_on :tags

  scope :available_for, -> (user) { joins(column: { board: :memberships })
                                  .where(memberships: { user_id: user.id }) }
  scope :by_board, -> (title) { joins(column: :board).where(boards: { title: title }) }
  scope :filter_by_board, ->(title) { title ? by_board(title) : all }
  scope :assigned, ->(user) { where(assignee: user) }
  scope :created, ->(user) { where(user: user) }
  scope :search, ->(input) { input ? search_everywhere(input) : all }
  scope :filter, ->(filter, user) do
    case filter
    when "all"
      with_discarded
    when "deleted"
      with_discarded.discarded
    when "assigned"
      assigned(user)
    when "created"
      created(user)
    else
      all
    end
  end

  # @!method pg_search_scope
  #   Searches cards by card title, card body, creator first_name, creator last_name
  pg_search_scope :search_everywhere,
  against: [:title],
  associated_against: {
    assignee: [:first_name, :last_name],
    user: [:first_name, :last_name],
    rich_text_body: [:body]
  },
  using: {
    tsearch: {
      prefix: true,
      dictionary: "english"
    }
  }

  before_validation(on: :create) do
    self.position = self.column.last_card_position.to_i + 1
  end

  self.per_page = 10

  # @!method assign(user)
  #   Updates assignee of current card with user
  def assign!(user)
    update(assignee: user)
  end

  # @!method remove_assign
  #   Updates assignee of current card to nil
  def remove_assign!
    update(assignee: nil)
  end

  def notification_receivers
    [self.user, self.assignee].compact
  end

end
