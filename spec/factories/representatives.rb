# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :representative do
    name { Faker::Name.name }
    ocdid { Faker::Alphanumeric.alphanumeric(number: 10) }
    title { Faker::Job.title }
    street { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip_code }
    political_party { %w[Democrat Republican Independent].sample }
    photo_url { Faker::Internet.url(host: 'example.com', path: '/image.jpg') }
    created_at { Faker::Time.forward(days: 20, period: :morning) }
    updated_at { created_at + rand(1..100).days }
  end
end
