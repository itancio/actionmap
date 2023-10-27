# frozen_string_literal: true

class County < ApplicationRecord
  belongs_to :state
  has_many :events, dependent: :delete_all

  # Standardized FIPS code eg. 001 for 1.
  def std_fips_code
    fips_code.to_s.rjust(3, '0')
  end
end
