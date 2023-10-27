# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :county do
    name { Faker::Address.city }
    fips_code { Faker::Number.between(from: 1, to: 99) }
    fips_class { Faker::Alphanumeric.alphanumeric(number: 2).upcase }
    state
  end
end
