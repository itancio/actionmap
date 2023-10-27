# frozen_string_literal: true

Given /^I add an article "(.*)" for "(.*)" with link "(.*)", description "(.*)", issue "(.*)"$/ do
|title, rep, link, descr, issue|
  steps %(
    Given I click on the "Add News Article" link
    And I fill in "Brief title of article..." with "#{title}"
    And I fill in "Link to external article..." with "#{link}"
    And I fill in "Describe the contents of the article..." with "#{descr}"
    And I select "#{rep}" from "Representative"
    And I select "#{issue}" from "Issue"
    And I press "Save"
  )
end

Given /^I edit the first article to have title "(.*)", link "(.*)", description "(.*)", issue "(.*)"$/ do
|title, link, descr, issue|
  steps %(
    Given I follow the first "Edit" link
    And I fill in "Brief title of article..." with "#{title}"
    And I fill in "Link to external article..." with "#{link}"
    And I fill in "Describe the contents of the article..." with "#{descr}"
    And I select "#{issue}" from "Issue"
    And I press "Save"
  )
end

# Add a declarative step here for populating the users table with users
Given /the following news items exist/ do |news_items_table|
  news_items_table.hashes.each do |news_item|
    NewsItem.create(news_item)
  end
end

# Ensure that seed representatives exists
Then /^(\d+) seed news item should exist/ do |count|
  expect(NewsItem.count).to eq count.to_i
end

# For visiting a news items page directly
Given /^(?:|I )visit the news items with representative id (\d{3})$/ do |id|
  visit representative_my_news_item_path(id)
end
