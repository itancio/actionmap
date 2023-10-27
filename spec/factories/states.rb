# frozen_string_literal: true

require 'faker'

# FactoryBot.define do
#   factory :state do
#     name { "California" }
#     symbol { "CA" }
#     # ... any other attributes you want to set ...
#   end
# end

FactoryBot.define do
  factory :state do
    name { Faker::Address.state }
    symbol { Faker::Address.state_abbr }
    fips_code { Faker::Number.between(from: 1, to: 9) }
    is_territory { [0, 1].sample } # Assuming this is a binary flag (0 or 1)
    lat_min { Faker::Address.latitude }
    lat_max { Faker::Address.latitude }
    long_min { Faker::Address.longitude }
    long_max { Faker::Address.longitude }
  end
end
