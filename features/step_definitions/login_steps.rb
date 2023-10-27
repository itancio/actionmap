# frozen_string_literal: true

# Add a declarative step here for populating the users table with users
Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create(user)
  end
end

Given /I am logged in/ do
  steps %(
    Given I visit the "login" page
    And I press "Sign in with Google"
  )
end
