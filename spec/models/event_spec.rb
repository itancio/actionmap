# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  before do
    @state = create(:state)
    @county1 = create(:county, state: @state, name: 'Alameda')
    @county2 = create(:county, state: @state, name: 'San Francisco')
    @event = create(:event, county: @county1)
  end

  describe 'validations' do
    it 'validates start_time is after or equal to today' do
      event = build(:event, start_time: 1.day.ago)
      expect(event).not_to be_valid
      expect(event.errors[:start_time]).to include('must be after today')
    end

    it 'validates end_time is after or equal to start_time' do
      event = build(:event, start_time: Time.zone.now, end_time: 1.day.ago)
      expect(event).not_to be_valid
      expect(event.errors[:end_time]).to include('must be after start time')
    end
  end

  describe '#county_names_by_id' do
    it 'returns a hash of county names by id' do
      expected_result = {
        'Alameda'       => @county1.id,
        'San Francisco' => @county2.id
      }

      expect(@event.county_names_by_id).to eq(expected_result)
    end

    it 'returns an empty array if county is nil' do
      event = build(:event, county: nil)
      expect(event.county_names_by_id).to eq({})
    end
  end
end
