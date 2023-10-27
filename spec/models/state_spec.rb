# frozen_string_literal: true

require 'rails_helper'

RSpec.describe State, type: :model do
  describe '#std_fips_code' do
    it 'returns the fips_code with leading zeros to make it 2 characters long' do
      state = described_class.new(fips_code: 6)
      expect(state.std_fips_code).to eq('06')

      state_with_three_digit_fips_code = described_class.new(fips_code: 123)
      expect(state_with_three_digit_fips_code.std_fips_code).to eq('123')
    end
  end
end
