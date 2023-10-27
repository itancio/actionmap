Feature: Be able to add, view, edit, and delete articles for a given representative

As a person who likes engaging with political articles
So that I can explore articles for a given representative
I want to be able to add, read, update, and delete their articles

Background: we are on the news article page
  Given I am logged in
  And I visit the "representatives" page
  And I fill in "address" with "San Francisco"
  And I press "Search"
  And I follow the first "News Articles" link #Joe Biden

Scenario: add, view, edit, and delete a single article
  #One long scenario to test (almost) all button clicks
  Given I click on the "Add News Article" link
  Then I should see "Find a news article"
  When I select "Kamala D. Harris" from "Representative"
  And I select "Student Loans" from "Issue"
  And I press "Search"
  Then I should see "News article search results"
  When I follow the first "Kamala D. Harris" link
  Then I should see "Vice President of the United States"
  When I click on the "Back" link
  Then I should see "News article search results"
  When I press "Save"
  Then I should see "Please select a news article"
  #this next line indicates that we chose the first news article on the page
  When I choose "0"
  And I press "Save"
  Then I should see "News item was successfully created"
  When I click on the "Edit" link
  Then I should see "Edit news article"
  When I fill in "Title" with "This is a very bad title"
  And I press "Save"
  Then I should see "News item was successfully updated"
  When I click on the "Edit" link
  And I click on the "Show article" link
  Then I should see "This is a very bad title"
  When I follow the first "Kamala D. Harris" link
  Then I should see "Vice President of the United States"
  When I click on the "Back" link
  Then I should see "This is a very bad title"
  When I click on the "View all articles" link
  Then I should see "Listing News Articles for Kamala D. Harris"
  And I should see "This is a very bad title"
  #ensure that there is only one, and not two, articles after editing title
  And I should not see "Dems slam"
  #test the show CRUD method
  When I follow the first "Info" link
  Then I should see "Link:"
  And I should see "Description:"
  When I click on the "View all articles" link
  And I follow the first "Edit" link
  Then I should see "Edit news article"
  When I click on the "View all news articles" link
  And I press "Delete"
  Then I should see "News was successfully destroyed"

Scenario: going back from the find news articles page
  Given I click on the "Add News Article" link
  And I click on the "View news articles" link
  Then I should see "Listing News Articles for Joseph R. Biden" 
