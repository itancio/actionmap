Feature: Go back to the search results from the news site or the representative profile site

As a website user
So that I can easily navigate back to the representatives that I searched for
I want to be able to click a button

Background:
Given I am logged in
And I visit the "representatives" page
Then I fill in "address" with "San Francisco"
Then I press "Search"

Scenario: Go back to search results from news articles page
  When I follow the first "News Articles" link
  And I follow the first "All Representatives" link
  Then I should be viewing the search results

Scenario: Go back to search results from profile page
  When I follow the first "Joseph R. Biden" link
  And I follow the first "Back" link
  Then I should be viewing the search results

Scenario: Go back to search results from news articles page when coming from other page
  When I follow the first "News Articles" link
  And I click on the "Add News Article" link
  And I click on the "View news articles" link
  Then I should see "Listing News Articles" 
  When I click on the "All Representatives" link
  Then I should be viewing the search results
