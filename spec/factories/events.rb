# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :event do
    name { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.paragraph }
    start_time { Faker::Time.forward(days: 20, period: :morning) }
    end_time { start_time + Faker::Number.between(from: 1, to: 5).days }
    county
  end
end
