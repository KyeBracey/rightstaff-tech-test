# Right Staff Tech Test

Thank you for giving me the opportunity to attempt this test.  Please see below for user instructions and an explanation of my approach to completing the task.

## Requirements

Your task is build API endpoints for a nurse resource.

Your endpoints should allow the client to perform the following:
* View all nurses in the system
* View a single nurse object
* Create a single nurse object
* Update a single nurse object
* Delete a single nurse object

Your endpoints should include **all** the fields on the nurse table.

`verified` and `sign_in_count` fields should not be updatable via the API.

The initial Rails application has already been built. Along with some database tables and models. You shouldn't need to modify the database or models.

## Instructions

### Getting started

- Clone this repo to your local machine
- `$ bundle install`
- `$ rails db:create`
- `$ rails db:migrate`
- To run the tests: `$ rspec`
- To run the API: `$ rails s` - this will tell you the base URL to send requests to (http://localhost:3000 by default)

### To view all nurses in the system

Send a GET request to `/nurses`.

### To view a single nurse object

Send a GET request to `/nurses/:id`, where :id is an integer matching the id of the nurse you wish to view.

### To create a new nurse object

Send a POST request to `/nurses`, with the following params:

- role: an integer matching the id of a Role in the system, or a Role object itself
- email: a string, which must match the pattern of an email address (eg `test@test.com`)
- first_name: a string
- last_name: a string
- phone_number (optional): a string
- verified (optional): a boolean value (true or false)
- sign_in_count (optional): an integer

### To update a nurse object

Send a PUT request to `/nurses/:id`, where :id is an integer matching the id of the nurse you wish to update, with any of the params applicable to a /create request, excluding `verified` and `sign_in_count`.

### To delete a nurse object

Send a DELETE request to `/nurses/:id`, where :id is an integer matching the id of the nurse you wish to delete.

## Approach

This was my first time building an API-only application with Rails, so I spent some time researching how to go about this (specifically how to send JSON as a response instead of rendering a view, as I have been used to doing).  I added the `rspec-rails` gem to the project so I could test-drive my solution and added the `nurses` resource to `routes.rb`, which gave me a good reference to make sure I adhered to RESTful conventions as well as setting up the routes for me.

At each stage of the process, I used RSpec tests to cover the behaviour of my code, and used [Postman](https://www.getpostman.com/) along with the SQLite3 CLI to check that the correct changes could be made to the database.

I took very small steps with each controller action I wrote, starting with a 'responds with 200' test each time to make sure the route and method were set up correctly.  Initially I was using `assigns` to assert the presence of the Nurse objects, but that required using instance variables in the controller methods so I noted this as something to rectify when I had found a way to test it without these - I later came up with the alternative of using JSON.parse so I could look in to each element of the response, and while this made the test a little less clean (to assert equality I had to convert the test nurse objects to JSON and then parse), I decided I would rather have cleaner code at this expense.

I used strong params by creating the `nurse_params` method in the controller, so that requests with incorrect or non-existent fields cannot have a negative effect on the database - I later added a second helper method (`nurse_update_params`) so that the `verified` and `sign_in_count` fields could not be updated (I understood _updatable_ to be the key word in the instructions here, so they can be set upon creation of a new nurse object, but cannot be changed via the API later on).
