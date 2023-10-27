# frozen_string_literal: true

require 'date'

Given /^I select a start date (\d+) days after today$/ do |num_days|
  future_date = DateTime.now.days_since(num_days)
  steps %(
      Given I select "#{future_date.year}" from "event_start_time_1i"
      And I select "#{Date::MONTHNAMES[future_date.month]}" from "event_start_time_2i"
      And I select "#{future_date.day}" from "event_start_time_3i"
    )
end

Given /^I select an end date (\d+) days after today$/ do |num_days|
  future_date = DateTime.now.days_since(num_days)
  steps %(
      Given I select "#{future_date.year}" from "event_end_time_1i"
      And I select "#{Date::MONTHNAMES[future_date.month]}" from "event_end_time_2i"
      And I select "#{future_date.day}" from "event_end_time_3i"
    )
end

# Add a declarative step here for populating the events table with events
Given /the following events exist/ do |events_table|
  events_table.hashes.each do |event|
    county = County.find(event['county_id'].to_i)
    event['start_time'] = DateTime.now + 1.day
    event['end_time'] = DateTime.now + 2.days
    county.events.create!(event)
  end
end

# Ensure that seed events exists
Then /(.*) seed events should exist/ do |n_seeds|
  expect(Event.count).to eq n_seeds.to_i
end

# Add a declarative step here for populating the states table with states
Given /the following states exist/ do |states_table|
  states_table.hashes.each do |state|
    State.create(state)
  end
end

# Ensure that seed states exist
Then /(.*) seed states should exist/ do |n_seeds|
  expect(State.count).to eq n_seeds.to_i
end

# Add a declarative step here for populating the counties table with counties
Given /the following counties exist/ do |counties_table|
  counties_table.hashes.each do |county|
    state = State.find(county['state_id'].to_i)
    state.counties.create(county)
  end
end

# Ensure that seed counties exist
Then /(.*) seed counties should exist/ do |n_seeds|
  expect(County.count).to eq n_seeds.to_i
end
