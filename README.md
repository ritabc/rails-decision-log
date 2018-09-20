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

## Goals for First Draft
* Deploy to Heroku
* Complete Home Page
* Integration Tests
  - When logged out, cannot go to decisions/new page

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

* To create a super_admin login, add a db/seeds directory, and a admins.rb file within there, and add this code to that file:
```admins = User.create!([{email: 'your_email', password: 'a_password', password_confirmation: 'a_password', admin_type: 'super'}])```
Optionally add another with a regular admin_type: 'admin'
Then run ```rails db:reset``` or ```rails db:seed```

## Authentication and Authorization.
### User Type and User Stories
* 'viewer' (user.type that doesn't exist - anyone can view w/o logging in) Can see:
  - '/' : all New/Unincorporated decisions, sorted into D's with past review by date, and D's with upcoming review by dates
  - '/archives' : all decisions, with sort and search features
* 'super_admin':
  - +, -, update: decisions, circles, admins
* 'admin':
  - + decisions
* There won't be a way to signup, since I'll create superadmins. Superadmins can create admins, and can change them to superadmins. SA's will need to know the email of an Admin they are creating
* Sortable columns on All Decisions page:
 - Decision name, Deciding Circle, Date Decided

## Stretch Goals
* Add password length validation and corresponding error message : if the user tries to sign up with a short password, there is an appropriate error message
* Forgot Password? feature for Admins and SA's
* Search Feature (words in decision)
