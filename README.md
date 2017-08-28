# Timekeeping RESt API

This application helps you keep track of your time. You can interact with it using REST API.

##Getting Started
###Prequisites

* Ruby version  : 
Version 2.3.1 is currently used and we don't guarantee everything works with other versions. If you need multiple versions of Ruby, RVM is recommended.
* Rails version : Rails 5.1.3
* Bundler : ````gem install bundler````
* A database. Only MySQL 5.7 has been tested, so we give no guarantees that other databases (e.g. PostgreSQL) work. 
###Setting up development environment
1. Get the code. Clone this git repository and check out the latest release:
```git clone git:git@github.com:jasjammy/timekeeping-api.git```
```cd timekeeping-api```
```git checkout master ``` 
   
2.Install the required gems by running the following command in the project root directory:
``bundle install``

###Running Tests
Tests are handled by RSpec for unit tests.
To run tests, do 
``bundle exec rspec``

##Technology stack
* Ruby 2.3
* Rails 5.1.3
* Gems :
    * Rspec : Testing framework
    * Factory Girl : Testing
    * Faker : Faking data
    
    
##Technical Decisions
* This API is a JSON API. Since there is no frontend to this application, JSON was better when making requests on the command line.
Heroku app link : https://secure-savannah-61519.herokuapp.com/

Using httpie from command line you can do the following
````http get https://secure-savannah-61519.herokuapp.com/timecards````
Result: 

`` HTTP/1.1 200 OK
   Cache-Control: max-age=0, private, must-revalidate
   Connection: keep-alive
   Content-Type: application/json; charset=utf-8
   Date: Mon, 28 Aug 2017 19:53:57 GMT
   Etag: W/"93ec921d36a1aa8f15cbfa119a0132ed"
   Server: Cowboy
   Transfer-Encoding: chunked
   Via: 1.1 vegur
   X-Request-Id: 224cfdd4-9dce-4d3a-8fb2-8c399e544b39
   X-Runtime: 0.042880
   
   {
       "created_at": "2017-08-28T19:53:58.193Z",
       "id": 1,
       "occurence": "2017-08-27",
       "total_hours_worked": 0,
       "updated_at": "2017-08-28T19:53:58.193Z",
       "username": "joanne"
   } ``
   
``http get https://secure-savannah-61519.herokuapp.com/time_entries``
``http post https://secure-savannah-61519.herokuapp.com/time_entries timecard_id=1 time='2017-08-27 10:00:00' ``
##Assumptions

###Timecard 
A Timecard is the model that has username and occurence. It has many Time Enteries.
I assume, that there is a Timecard per day. I assume that the user is only entering a Timecard for that day. 

###Time Entry
A Time Entry belongs to only one Timecard. A Time Entry can represent a start or end time. This depends on the other entries for that Timecard.
  
###Hours Worked
When a Timecard has more than one Time Entry, hours worked is calculated.
Each entry is either a start or an end time. If there are two entries that belong to one timecard, the earlier time entry is the start time and the later time entry is the end time.
The Time Entries are ordered by time, ascending. The hours are calculated by pairing the times together.

Like so:
Time Entries ordered by time : [11am, 12pm, 4pm]
Hence, the total hours worked will be the time between 11am and 12pm which is an hour. 
4pm is not taken into account as there is no end time. But when another Entry is put in, it re-calulates it.
Time Entries ordered by time : [11am, 12pm, 4pm, 5pm]
Now, total hours worked is 2.

###If I had more time
* Put validations on Timecard and TimeEntry such that a TimeEntry is created for the same day as the parent Timecard.
* Restrict creation of Timecard and TimeEntry so that you cannot create them for the future. 
* Add seed data for the database 
* Instead of 422, I would respond with 404 when resource was not found. As it is a better error message.
* Add User login and password. 



