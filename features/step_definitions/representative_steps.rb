# frozen_string_literal: true

# Checks if we are on the search results page
Then /^(?:|I )should be viewing the search results$/ do
  # Ensure that we can see the search result table headers
  page.should have_content('Name')
  page.should have_content('Office')
  page.should have_content('Links')
  current_path = URI.parse(current_url).path
  # Also ensure correct url format
  current_path.should match(/search/)
end

# For visiting a profile page directly
Given /^I visit the profile for the representative with id "(.*)"/ do |id|
  visit "/#{place}/#{id}"
end

# For visiting a news items page directly
Given /^I visit the news items for the representative with id "(.*)"/ do |id|
  visit "/#{place}/#{id}/news_items"
end

# Checks if we are on someone's profile page
Then /^(?:|I )should be visiting the profile page for "([^"]*)"$/ do |rep_name|
  # Ensure that the page contains the rep_name in its body
  page.should have_content(rep_name)
  current_path = URI.parse(current_url).path
  # Also ensure correct url format
  current_path.should match(%r{representatives/\d})
end

# Checks if we are not on a given page
Then /^(?:|I )should not be on the "([^"]*)" page$/ do |page_name|
  # Ensure that the page contains the rep_name in its body
  current_path.should_not match(/#{page_name}/)
end

# Click the first link that appears with given text to resolve ambiguities
When /^(?:|I )follow the first "([^"]*)"/ do |link|
  first(:link, link).click
end

# For visiting a given path on our page
Given /^I visit the "(.*)"/ do |place|
  visit "/#{place}"
end

# For clicking on a link
When /I click on the "(.+)" link/ do |locator|
  page.click_link locator
end

# Add a declarative step here for populating the representatives table with reps
Given /the following representatives exist/ do |representatives_table|
  representatives_table.hashes.each do |representative|
    Representative.create(representative)
  end
end

# Ensure that seed representatives exists
Then /(.*) seed representatives should exist/ do |n_seeds|
  expect(Representative.count).to eq n_seeds.to_i
end
