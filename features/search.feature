Feature: Search for representatives by address
  As a user
  So that I can find my representatives near an address
  I want to search for my representatives by address

Scenario: Search with valid address
  Given I am on the home page
  When I go to representatives page
  Then I should be on the representatives page
  When I fill in "address" with "San Francisco, CA"
  And I press "Search"
  Then I should be on the search page
  And I should see "Gavin Newsom"

Scenario: Search with a blank address
  Given I am on the home page
  When I go to representatives page
  Then I should be on the representatives page
  When I press "Search"
  Then I should be on the representatives page
  Then I should see "Address cannot be blank"

Scenario: Search with an Invalid address
  Given I am on the home page
  When I go to representatives page
  Then I should be on the representatives page
  When I fill in "address" with "asdlkfjh"
  And I press "Search"
  Then I should be on the representatives page
  Then I should see "Invalid Address"
