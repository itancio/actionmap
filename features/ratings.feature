Feature: Be able to rate articles and view my ratings

As a website user
So that I can easily remember which articles I liked and disliked
I want to be able to easily rate them

Background: we are on the news article page
  Given I am logged in
  And I visit the "representatives" page
  And I fill in "address" with "San Francisco"
  And I press "Search"
  And I follow the first "News Articles" link #Joe Biden

Scenario: create, update, view, and edit an article rating
  Given I click on the "Add News Article" link
  And I press "Search"
  And I choose "0"
  And I select "4" from "Rating"
  And I press "Save"
  Then I should see "News item was successfully created"
  And I should see "Your Rating"
  And I should see "4"
  When I click on the "View all articles" link
  And I follow the first "Edit" link
  And I select "1" from "Rating"
  And I press "Save"
  Then I should see "News item was successfully updated"
  And I should see "Your Rating:"
  And I should see "1"
  When I click on the "View all articles" link
  And I follow the first "Info" link
  Then I should see "Your Rating:"
  And I should see "1"

Scenario: view an article rating without being logged in
  Given I click on the "Add News Article" link
  And I press "Search"
  #choose the first article
  And I choose "0"
  And I select "4" from "Rating"
  And I press "Save"
  And I click on the "Welcome" link
  And I follow the first "Logout" link
  #now on homepage, go back to where we came from
  And I visit the "representatives" page
  And I fill in "address" with "San Francisco"
  And I press "Search"
  And I follow the first "News Articles" link #Joe Biden
  And I follow the first "Info" link
  Then I should see "Your Rating:"
  And I should see "N/A (not logged in)"
