# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Setup Instructions
* Clone the repo
* Set up the Database
```
rails db:create
rails db:migrate
```
* For testing environments:
``` rails db:test:prepare```
* To launch the server:
```rails server```

## Stretch Goals
* Add password length validation and corresponding error message : if the user tries to sign up with a short password, there is an appropriate error message
