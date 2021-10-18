# README

This README would normally document whatever steps are necessary to get the
application up and running.

* Github Link: https://github.com/alihaidar-devsinc/instagram
* Heroku Link: https://insta-by-ali.herokuapp.com/

* Description: This is a instagram clone project, where users can create account and add post and stories. User can follow each other and it has comment and like functionality.

Things you may want to cover:

* Configurations: You need to add application credentials in credentials.yml as follow:

  - api_key
  - api_secret
  - cloud_name
  - email_user_name
  - email_password
  - address
  - domain
  - db_name
  - host_url
  - redis_url

* Prerequisite

  - Ruby version - 2.7.2
  - Rails version - 5.2.6
  - Database - Postgres : 13.4

* Services (job queues, cache servers, search engines, etc.) :

  - sidekiq
  - redis
  - cloudinary
  - active-storage

* Deployment instructions :

  - Add all the credentials mentioned above on heroku
  - such as: cloud_name, api_key, api_secret and all others

* How to run on Local :

  - git clone https://github.com/alihaidar-devsinc/instagram
  - rails db:setup
  - bundle install
  - rails s
