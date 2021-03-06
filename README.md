<h1 align="center"> Projector </h1><br>
<p align="center">
  <a href="https://github.com/Synkevych/projector">
    <img alt="Projector logo" title="Projector" src="/public/images/projector_logo.svg" width="75">
  </a>
</p>
<br>
<a href="https://codecov.io/gh/Kv065RubySSTeam/projector">
  <img src="https://codecov.io/gh/Kv065RubySSTeam/projector/branch/master/graph/badge.svg" />
</a>
<a href="https://travis-ci.org/Kv065RubySSTeam/projecto">
  <img src="https://travis-ci.org/Kv065RubySSTeam/projector.svg?branch=master" />
</a>
<a href="http://hits.dwyl.com/Synkevych/projector">
  <img src="http://hits.dwyl.com/Synkevych/projector.svg" />
</a>
<p>
  <img src="https://img.shields.io/badge/ruby-%23CC342D.svg?&style=for-the-badge&logo=ruby&logoColor=white"/>
  <img src="https://img.shields.io/badge/rails%20-%23CC0000.svg?&style=for-the-badge&logo=ruby-on-rails&logoColor=white"/>
  <img src="https://img.shields.io/badge/AWS%20-%23FF9900.svg?&style=for-the-badge&logo=amazon-aws&logoColor=white"/>
  <img src="https://img.shields.io/badge/nginx%20-%23009639.svg?&style=for-the-badge&logo=nginx&logoColor=white"/>
  <img src ="https://img.shields.io/badge/postgres-%23316192.svg?&style=for-the-badge&logo=postgresql&logoColor=white"/>
  <img src="https://img.shields.io/badge/travisci%20-%232B2F33.svg?&style=for-the-badge&logo=travis&logoColor=white"/>
</p>
<p align="center">
Projector is a collaboration tool that organizes your projects into boards. In one glance, Projector tells you what's being worked on, who's working on what, and where something is in a process.
</p>

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Responsibilities](#responsibilities)
- [Getting started](#getting-started)
- [Usage](#usage)
  - [UI](#UI)
  - [API](#API)
- [Feedback](#feedback)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Introduction

Projector is a collaboration tool that organizes your projects into boards. In one glance, Projector tells you what's being worked on, who's working on what, and where something is in a process.

<img src="/public/images/projector_screenshot.png">

**Technology Stack:**
Ruby, Rails, Devise, Sidekiq, Redis, RSpec, Rubocop, Yardoc, Capistrano, Puma, Passenger, Nginx, AWS (EC2, S3, SES), PostgreSQL, Rails API, Bootstrap, jQuery, Haml, Webpack, Github, GitHub Actions, TravisCI, Kanban, Frest Bootstrap Template.

## Features

#### A few of the things you can do with Projector:

Create a public or private board for a specific type of task, such as "homework" and "job". Create columns inside the board with a more precise description of the project or group of tasks. Inside the columns, create cards with a description of the task itself, add a user responsible for completing the task, set the task completion time or add a picture with implementation details and a hashtag.

- Sign up/Login to app
- Load user image or update user info
- Create new board public(all user can see them) or private
- Create new column inside board
- Create new card inside column
- Edit information inside card
- View all user cards
- View user notification
- REST API available on AWS EC2 instance <http://3.129.9.9/api/v1/login>

## Responsibilities

On this project, I took part in the following:

* Investigated Turbolinks and Rails-ujs for AJAX
* Investigated JWT and jwt gem
* Investigated Continuous Integration
* Configure authentication functionality with Device gem
* Implement Columns logic and UI
* Implement Cards logic and UI
* Created index page for Cards
* Wrote unit tests for Membership
* Have added Time Tracking
* Implemented User API and tests for it
* Implemented Facebook Authentications using koala library
* Added email notifications for Cards
* Create and configure AWS instance for deployment
* Create and configure access for AWS S3 and AWS SES
* Implement deploying cron jobs using whenever gem

## Getting started

### Prerequisites

The setups steps expect following tools installed on the system.

- GitHub
- Ruby [2.5.5](https://www.ruby-lang.org/en/news/2019/04/17/ruby-2-6-3-released/)
- Rails [6.0.2](https://weblog.rubyonrails.org/2020/5/18/Rails-5-2-4-3-and-6-0-3-1-have-been-released/)
- PostgreSQL [>=9.3](https://www.postgresql.org/download/)
- Redis [>=6.0.8](https://redis.io/topics/quickstart)
- yarn [>=1.22.5](https://classic.yarnpkg.com/en/docs/install)

#### 1. Check out the repository

```bash
git clone https://github.com/Synkevych/projector.git
```

#### 2. Install all gems and libraries required to this repository

```bash
bundle install
yarn install
```

#### 3. Create database.yml file

Copy the sample database.yml file and edit the database configuration as required.

```bash
cp config/database.yml.sample config/database.yml
```

#### 4. Create and setup the PostgreSQL database

Run the following commands to create and setup the database.

```ruby
rails db:setup
rails db:migrate
```

You must specify the user and his password to access the database.

#### 5. Generate new credentials

You need to generate new credentials or ask me for master.key by sending me an email.

```bash
rm config/credentials.yml.enc

EDITOR=vim rails credentials:edit
```

#### 6. Specify accesses AWS S3 and Amazon Simple Email Service

This repository uses AWS Simple Storage Service for saving images and AWS SES to send email inside production server.
So you need to specify your access_key_id and secret_access_key to this services inside your credentials or comment them is you use this repository locally.

a) Comment to use locally

```bash
vim config/storage.yml
# comment all inside section amazon, so that they look like this:

# amazon:
#   service: S3
#   access_key_id: <%= Rails.application.credentials.aws[:bucket_access_key_id] %>
#   secret_access_key: <%= Rails.application.credentials.aws[:bucket_secret_access_key]  %>
#   region: 'us-east-2'
#   bucket: 'projector-bucket'

vim config/initializers/amazon_ses.rb
# comment all inside this file, so that they look like this:

#ActionMailer::Base.add_delivery_method :ses, AWS::SES::Base,
#                                       :server => 'email.us-west-2.amazonaws.com',
#                                       :access_key_id => Rails.application.credentials.aws[:access_key_id],
#                                       :secret_access_key => Rails.application.credentials.aws[:secret_access_key]
```

b) Specify accesses in your credential file

```bash
EDITOR=vim rails credentials:edit
# it will look like this
aws:
  access_key_id: your_ses_access_key_id
  secret_access_key: your_ses_secret_access_key
  bucket_access_key_id: your_access_key_id
  bucket_secret_access_key: your_secret_access_key
secret_key_base: 123 # not changed
```

#### 7. Install and start Redis

```bash
wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
cd redis-stable
make
sudo make install
#Starting Redis
redis-server
```

#### 8. Start SideKiq

```bash
# inside projector folder run
bundle exec sidekiq
```

And now you can visit the SideKiq website with the URL http://localhost:3000/sidekiq

#### 9. Start Rails server

You can start the rails server using the command given below.

```bash
rails s
```

And now you can visit the site with the URL <http://localhost:3000>  
REST API available on address <http://localhost/api/v1/login>

#### 10. Running specs tests

You can run all tests using the command given below.

```bash
# Default: Run all spec files (i.e., those matching spec/**/*_spec.rb)
$ rspec

# Run all spec files in a single directory (recursively)
$ rspec spec/models

# Run a single spec file
$ rspec spec/request/boards_request_spec.rb

# Run a single example from a spec file (by line number)
$ rspec spec/request/boards_request_spec.rb:56

# Run a single example from a spec API
$ rspec spec/requests/api/v1/authentication_request_spec.rb

# See all options for running specs
$ rspec --help
```

## Usage

### UI

#### 1. Login or Sign in

It is simple as possible. Use one of the types to log in to the program: facebook credentials or use your email address to create a new user.

![login page](public/images/usage/projector_login.png)

#### 2. Create your own board

Upon successful login, you will see all public user-created boards.

![boards index page](public/images/usage/projector_index_boards.png)

Here you can create a new board by clicking "Add new board". Provide a name, description and choose which type of board you want to create - private or public.

![create a new board](public/images/usage/projector_create_new_board.png)

#### 3. Create new column

After creating a new board, you can create a new column. The column is similar to the days of the week, so you can divide the task into a separate column. Click to "Add New Column", that create a new column with a template name, just hover over it and change name to your own.

![create a new column](public/images/usage/projector_new_column.png)

#### 4. Create new card

Cards it your task, you can add name and descriptions, add some image or link.

![create a new card](public/images/usage/projector_new_card.png)

#### 5. Get more information about your cards

By clicking on the card, you will see a card editing page where you can do a lot, add a assignee, add some tag, set a start date and create a duration for specific tasks, change history and add a comment.

![edit card](public/images/usage/projector_edit_card.png)

#### 6. Notification

![cards notifications](public/images/usage/projector_notifications.png)

#### 7. All your cards(from all boards)

![cards index](public/images/usage/projector_cards_index.png)

### API

#### 1. Login

For the first you need to get Authorization Bearer token for make request to projectors API. So you need to login, or sign in.
For example to login make request with json body content:

POST <http://3.129.9.9/api/v1/login>

```json
{"email":"your@mail.com", "password":"password"}
```

The result of this request, information about user:

```json
{
    "id": 2,
    "email": "pupkin@mail.com",
    "first_name": "Pupkin",
    "last_name": "Anton",
    "created_at": "2020-10-20T11:07:27.645+03:00",
    "updated_at": "2020-10-25T23:33:34.050+02:00",
    "receive_emails": true
}
```

Now, you can find your token inside Headers(`Authorization: Bearer:`):

```json
Content-Type: application/json; charset=utf-8
Transfer-Encoding: chunked
Connection: keep-alive
Status: 200 OK
Cache-Control: max-age=0, private, must-revalidate
Referrer-Policy: strict-origin-when-cross-origin
Authorization: Bearer: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE2MDM2NzYwMTQsImp0aSI6ImVkYzY1ZjI3LWIxMjEtNDNhOS04YjQ0LTBkOTZlODZiNTJlNiJ9.YOPb9gQdRVKDpqh92F0nr56NOgyOKSr997Uo2HAV7eY
```

#### 2. Get information about your boards, columns or cards

Let's make request for take all your board, provide your token inside Headers > Authorization > Bearer Token

GET <http://3.129.9.9/api/v1/boards>
Authorization Bearer Token: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE2MDM2NzYwMTQsImp0aSI6ImVkYzY1ZjI3LWIxMjEtNDNhOS04YjQ0LTBkOTZlODZiNTJlNiJ9.YOPb9gQdRVKDpqh92F0nr56NOgyOKSr997Uo2HAV7eY


As a result you should see json with first 10 your boards.

```json
[
    {
        "id": 1,
        "title": "Voluptas armo pecco.",
        "description": "Ex crux patrocinor.",
        "public": false,
        "created_at": "2020-10-26T00:08:49.210+02:00",
        "updated_at": "2020-10-26T00:08:49.210+02:00",
        "creator": {
            "id": 1,
            "email": "admin@gmail.com",
            "first_name": "Cassaundra",
            "last_name": "Boyer",
            "created_at": "2020-10-26T00:08:48.369+02:00",
            "updated_at": "2020-10-26T00:15:04.597+02:00",
            "receive_emails": true
        }
    }
]
```

## Feedback

Feel free to send me feedback on [Twitter](https://twitter.com/synkevych) or [file an issue](https://github.com/Synkevych/projector/issues/new). Feature requests are always welcome.
