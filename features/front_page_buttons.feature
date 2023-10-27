Feature: Front page navigations

As a first time website visitor
I want to be able to click tabs on the nav menu bar
So that I can easily navigate find information about a representative

Background:
  Given I am on the homepage
  Then I should see "National Map"
  And I should see "Actionmap"
  And I should see "Home"
  And I should see "Events"
  And I should see "Representatives"
  And I should see "Login"

Scenario: Clicking the Events tab
  When I click on the "Events" link
  Then I should be on the events page
  And I should see "Events"
  And I should see the following words: Name, State, County
  And I should see the following words: Start Time, End Time
  And I should see the following words: Description, Link

Scenario: Clicking the Representatives tab
  When I click on the "Representatives" link
  Then I should be on the representatives page
  And I should see "Search for a Representative"
  And I should see "Enter a location:"

Scenario: Clicking the Login tab
  When I click on the "Login" link
  Then I should be on the login page
  And I should see "Sign in with Google"
  And I should see "Sign in with GitHub"

Scenario: Clicking the Profile tab
  Given I am logged in
  When I click on the "Welcome" link
  Then I should be on Google Test Developer's profile page
  And I should see "Your Profile"
  And I should see the following words: Name, Authentication Provider
  And I should see the following words: Email, Created, Last Updated, Logout