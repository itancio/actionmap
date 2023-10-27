# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :user do
    provider { %i[google_oauth2 github].sample }
    uid { SecureRandom.uuid }
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end
end
