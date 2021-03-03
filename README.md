# README

This are the steps necessary to get the application up and running.

###### Ruby version
    - 2.7.1

###### Ggems
    - pg
    - jbuilder

###### Gems for testing
    - faker
    - factory_bot_rails
    - rspec-rails

###### Configuration (standard rails json API)
    - clone this repo
    - move to the folder created
    - bundle install

###### Database creation
    - rails db:setup
    - rails db:migrate
    ** need to have pg database locally installed

###### redo: rails db:drop db:create db:migrate

###### Database initialization
    - rails db:seed

###### How to run the test suite
    - rspec

###### Services (job queues, cache servers, search engines, etc.)
    - none

###### Deployment instructions
    - none

* ...
