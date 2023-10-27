Feature: link to a representative's profile page from any place where their name appears on a page

As a curious student
So that I can quickly find information about a representative
I want to be able to visit their profile page by clicking their name

Background: We are on the representatives search page, and we searched for San Francisco
Given I visit the "representatives" page
Then I should be on the representatives page
And I should see "Search for a Representative"
And I should see "Enter a location:"
When I fill in "address" with "San Francisco"
And I press "Search"
Then I should see "Joseph R. Biden"

Scenario: View Joe Biden's profile page by clicking his name from his News Articles site
  When I follow the first "News Articles" link #assumes that Joe Biden's result is first displayed
  Then I should see "Listing News Articles for Joseph R. Biden"
  When I follow the first "Joseph R. Biden" link 
  Then I should be visiting the profile page for "Joseph R. Biden"

Scenario: View Joe Biden's profile page by clicking his name from the search results
  When I follow the first "Joseph R. Biden" link
  Then I should be visiting the profile page for "Joseph R. Biden"


