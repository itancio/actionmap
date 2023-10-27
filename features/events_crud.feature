Feature: Be able to add, view, edit, and delete events

As a person who likes organizing and attending political events
So that I can explore upcoming events
I want to be able to navigate through the website easily

Background: we are on the events page    
  Given the following states exist:
  | id      |      name         | symbol | fips_code   | is_territory     | lat_min  | lat_max  | long_min  | long_max     |
  |  1      |   California      | "CA"   |    6        |   true           |   5      |    8     |     4     |    6         |
  |  2      |   Oregon          | "OR"   |    41       |    true          |   3      |    11    |     2     |    7         |
  Then 2 seed states should exist
  And the following counties exist:
  | id      |      name             | state_id  | fips_code      | fips_class         |
  |  1      |   Alameda County      |   1       |     6          |  "LOL"             |
  |  2      |   Fresno County       |   1       |    41          |   "GARBAGE"        |
  |  3      |   Multnomah County    |   2       |    30          |   "NOT NULL"       | 
  Then 3 seed counties should exist
  And the following events exist:
  | name                    | county_id |
  | Pride Parade            |   1       |
  | Funfest                 |  2        | 
  | BLM                     |  3        |  
  Then 3 seed events should exist

Scenario: add invalid events
  #One long scenario to test (almost) all event CRUD actions
  Given I am logged in
  And I am on the events page
  And I click on the "Add New Event" link
  And I click on the "View all events" link
  Then I should be on the events page
  When I click on the "Add New Event" link
  Then I should see "New event"
  When I press "Save"
  Then I should see "Start time must be after today"
  When I fill in "Name of the event..." with "A"
  And I fill in "Description of the event..." with "A"
  And I select a start date 3 days after today
  And I select an end date 2 days after today
  When I press "Save"
  Then I should see "End time must be after start time"

Scenario: try to add event without being logged in
  Given I am on the events page
  Given I click on the "Add New Event" link
  Then I should see "Sign In"
  When I press "Sign in with Google"
  Then I should not be on the "login" page

Scenario: test CRUD with events
  Given I am logged in
  And I am on the events page 
  Then I should see "Pride Parade"
  When I follow the first "View" Link
  Then I should see "Event Details"
  When I click on the "Edit" link
  Then I should see "Edit event"
  When I fill in "Name of the event..." with "This is a bad event name" 
  And I press "Save"
  Then I should see "Event was successfully updated"
  When I follow the first "View" Link
  And I click on the "View all events" link
  Then I should be on the events page