# Decision Log in Rails
#### Created by Rita Bennett-Chew, for Common Ground Ecovillage (formerly known as Hart's Mill)
#### https://hmev-decision-log.herokuapp.com/

## Completed Features
* Home page of All Decisions, Sortable by Name, Circle, Date Decided
* Full-text search of Decisions using pg_search gem
* From scratch Authorization, including 3 tiers of User Types
* Use of BCrypt gem for Authentication
* Use of partials to DRY new & edit forms for decisions, circles, and users

## Summary of Database and Associations
At Common Ground, we have circles, which are groups that can be thought of like committees or working groups. The main circle is called 'General Circle', and we have Functional Circles (FCs) as well. Each FC has an Operational Leader (OL) and an Elected Representative (ER). The OL's and ER's of each Functional Circle make up the General Circle. Users of the site are, for the most part, either an OL or ER of an FC. They could also be a Circle Administrator for any circle.
I implemented a many-to-many relationship between circles and users, through roles.

## Screenshot of New Decision Page
#### As viewable by Leader and Super Users (Types of admins)
![image](https://user-images.githubusercontent.com/11031915/52574218-d1ae4600-2de9-11e9-8b33-c088935a7330.png)

## User Type, User Stories
#### (Some of this functionality is still in-progress)
* Public 'viewer.' Anyone, without logging in, can see:
  - all circles and decisions; Decisions are sorted by name, circle, or date decided, or filtered by circle or whether it has a review by date
* Login required for 'leader' tier. Above, plus can:
  - Add/Edit/delete own circle's decision
  - Add new circle
  - Update circles
  - Delete circles (iff circle has no decisions)
  - Delete self
  - Edit self
* Login required for 'super' tier. Above, plus can:
  - Edit leaders:
    - Add new admin (leader or super)
    - Delete
    - Graduate leader to Super
    - Degraduate Super to Leader
    - assign leaders/supers to circles
  - Edit other Supers
  - Add/edit/delete any decision
  - Delete Super
## Goals for the Application
* Continue to work with Common Ground Ecovillage to design this product with their needs in mind
* Beautify and advance the site's style
* 'Forgot Password' feature for Leaders and Supers, and Action Mailer in general
  - Additionally, a request invite feature where a viewer could enter their email, and an email would be sent to the super admins, telling them who requested to be added.
* Improve test coverage, including integration tests
* Have HM be a group - other organizations could use this tool as well
* 'Request Invite' feature: Since edits to these decisions are done by Common Ground Members only, a form where a viewer can request to be added as an leaders should be available. This would send an email the super users

## For contributions or to serve locally
1. Fork and clone the [repo](https://github.com/ritabc/rails-decision-log)
1. Run `bundle install` to install necessary
1. Create the database using `rails db:create`
1. Run migrations and prepare test database using `rails db:migrate` and `rails db:test:prepare`
1. Seed the database with `rails db:seed`
1. Launch server using `rails s`
1. To test, run `rspec`
1. Make changes and submit a PR
1. To create leaders (admin types) using the Rails Console:
  * Run `rails c`
  * See seeds file for commands for creating fake admin data

## Notes about the application
* Ruby v. 2.5.3
* Rails v. 5.2.1
* Uses PostgreSQL as the Active Record Database
* Deployed using Heroku
* Lightly styled with Bootstrap 4
* This application is licensed under the MIT license.

With help from following RailsCast episodes:
  - #228 Sortable Table Columns
  - #37 Simple Search Form
  - #343 Full-Text Search in PostgreSQL
  - #385, #386 Authorization from Scratch Parts 1 & 2

If you'd like to learn about Common Ground Ecovillage, see the [website](http://www.commonground.eco/) for more details.
