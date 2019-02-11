# Decision Log in Rails
#### Created by Rita Bennett-Chew, for Hart's Mill Eco-Village
#### https://hmev-decision-log.herokuapp.com/

## Completed Features
* Home page of Unincorporated Decisions (usually newer ones that are still pending review)
* A list of all decisions
* Decisions conducted by each circle
* Individual decisions page, including in some cases external links to Supporting Documents (Proposals for Change or Meeting Minutes)
* Login / Logout functionality for Admins and Supers
* Can only Add a Decision or view the New Decision Form if logged in as an admin or super
* Sortable columns on All Decisions page (with help from Ryan Bates' RailsCast #288)
  - Decision name
  - Deciding Circle
  - Date Decided
* Use of BCrypt gem for Authentication

## Screenshot of New Decision Page
#### As viewable by Admin and Super Users
![image](https://user-images.githubusercontent.com/11031915/52574218-d1ae4600-2de9-11e9-8b33-c088935a7330.png)

## User Type, User Stories
#### (Some of this functionality is still in-progress)
* Public 'viewer.' Anyone, without logging in, can see:
  - Home page with Unincorporated Decisions (usually newer ones)
  - all decisions; individually or sorted by name, circle, or ate decided.
* Login required for 'admin.' Above, plus can:
  - Can add new decisions
* Login required for 'super.' Above, plus can:
  - Delete decisions
  - Create, Edit, and Delete Circles
  - Create, Edit, and Delete Admins

## Goals for the Application
* Continue to work with Hart's Mill Eco-Village to design this product with their needs in mind
* Beautify and advance the site's style
* 'Forgot Password' feature for Admins and Supers
* Add password length validation and corresponding error message : if the user tries to sign up with a short password, there is an appropriate error message
* Search Feature (words in decision)
* Use the Devise gem for Authorization
* Add integration tests
* Have HM be a group - other organizations could use this tool as well
* 'Request Invite' feature: Since edits to these decisions are done by Hart's Mill Members only, a form where a viewer can request to be added as an admin should be available. This would send an email the supers

## For contributions or to serve locally
1. Fork and clone the [repo](https://github.com/ritabc/rails-decision-log)
1. Run `bundle install` to install necessary
1. Create the database using `rails db:create`
1. Run migrations and prepare test database using `rails db:migrate` and `rails db:test:prepare`
1. Seed the database with `rails db:seed`
1. Launch server using `rails s`
1. To test, run `rspec`
1. Make changes and submit a PR
1. To create admins using the Rails Console:
  * Run `rails c`
  * Use this template for creating admins: ```admins = User.create!([{email: 'your_email', password: 'a_password', password_confirmation: 'a_password', admin_type: 'super'}])```
  * Run `rails db:test:prepare`

## Notes about the application
* Ruby v. 2.5.3
* Rails v. 5.2.1
* Uses PostgreSQL as the Active Record Database
* Deployed using Heroku
* Lightly styled with Bootstrap 4.0.0
* This application is licensed under the MIT license.

If you'd like to learn about the Hart's Mill Eco-Village community/project, see the [website](http://www.hartsmill.org/) for more details.
