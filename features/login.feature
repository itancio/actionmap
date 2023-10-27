Feature: Be able to login and view login status

As a user
So that I can add articles for representatives
I want to be able to log into the website and see if I am logged in

Background:
  Given the following users exist:
  | uid             |   provider      |  email                          |  first_name  | last_name  |
  | chicken_nuggets |   google_oauth2 |  chickennuggets@chicken.chicken |  Chicken     | Nuggets    |
  | orange_apples   |   github        |  orange_apples@apples.oranges   |  Orange      | Apples     |



Scenario: attempt to login through Google when not logged in
  Given I visit the "login" page
  Then I should see "Sign In"
  When I press "Sign in with Google"
  Then I should not be on the "login" page

Scenario: attempt to login through GitHub when not logged in
  Given I visit the "login" page
  Then I should see "Sign In"
  When I press "Sign in with GitHub"
  Then I should not be on the "login" page

Scenario: already logged in and visits login page
  Given I am logged in
  When I visit the "login" page
  Then I should see "You are already logged in"
  When I follow the first "Logout" link
  Then I should see "You have successfully logged out"
  And I should be on the home page

Scenario: unable to add article without being logged in
  Given I visit the "representatives" page
  Then I fill in "address" with "San Francisco"
  And I press "Search"
  And I follow the first "News Articles" link
  When I click on the "Add News Article" link
  Then I should see "Sign In"