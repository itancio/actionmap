# frozen_string_literal: true

require 'rails_helper'

describe Representative do
  before do
    # Mock the API response
    @rep_info = OpenStruct.new(
      officials: [
        OpenStruct.new(
          name: 'John Doe', address:
          [
            OpenStruct.new(locationName: 'Location Name', line1: '123 Main St',
                           city: 'New York', state: 'NY', zip: '10001')

          ], party: 'Democratic',
          photo_url: 'https://www.google.com/'
        ),
        OpenStruct.new(
          name: 'Jane Smith', address:
          [
            OpenStruct.new(locationName: 'Location Name', line1: '456 Center Rd',
                           city: 'Los Angeles', state: 'CA', zip: '90001')
          ], party: 'Republican',
          photo_url: 'http://example.com/photo.jpg'
        )
      ], offices:
      [
        OpenStruct.new(name: 'Mayor', division_id: 'ocd-division/country:us', official_indices: [0]),
        OpenStruct.new(name: 'Governor', division_id: 'ocd-division/country:us/state:ca', official_indices: [1])
      ]
    )
    @representatives = described_class.civic_api_to_representative_params(@rep_info)
  end

  describe '.civic_api_to_representative_params' do
    context 'when rep_info is nil' do
      it 'returns an empty array' do
        expect(described_class.civic_api_to_representative_params(nil)).to eq([])
      end
    end

    context 'when rep_info is present' do
      it 'returns an array of representatives' do
        expect(@representatives).to all(be_a(described_class))
      end
    end
  end

  describe 'civic api to params' do
    it 'checks the attributes of the first representative' do
      expect(@representatives[0].name).to eq('John Doe')
      expect(@representatives[0].title).to eq('Mayor')
      expect(@representatives[0].ocdid).to eq('ocd-division/country:us')
    end

    it 'checks the attributes of the second representative' do
      expect(@representatives[1].name).to eq('Jane Smith')
      expect(@representatives[1].title).to eq('Governor')
      expect(@representatives[1].ocdid).to eq('ocd-division/country:us/state:ca')
    end

    it 'checks the number of representatives' do
      expect(@representatives.size).to eq(2)
    end
  end

  describe 'updated civic api' do
    it 'checks the added address attributes for rep1' do
      expect(@representatives[0].street).to eq('123 Main St')
      expect(@representatives[0].city).to eq('New York')
      expect(@representatives[0].state).to eq('NY')
      expect(@representatives[0].zip).to eq('10001')
    end

    it 'checks the added address attributes for rep2' do
      expect(@representatives[1].street).to eq('456 Center Rd')
      expect(@representatives[1].city).to eq('Los Angeles')
      expect(@representatives[1].state).to eq('CA')
      expect(@representatives[1].zip).to eq('90001')
    end
  end

  describe '.fetch_address' do
    it 'gets address' do
      official = @rep_info.officials.first
      street, city = described_class.fetch_address(official)
      expect(street).to eq(official.address.first.line1)
      expect(city).to eq(official.address.first.city)
    end

    it 'returns an array of empty strings' do
      official_without_address = OpenStruct.new(name: 'John Doe')
      expect(described_class.fetch_address(official_without_address)).to eq(['', '', '', ''])
    end
  end
end
