# frozen_string_literal: true

class AddRepresentativeProfileInfo < ActiveRecord::Migration[5.2]
  def change
    add_column :representatives, :street, :string
    add_column :representatives, :city, :string
    add_column :representatives, :state, :string
    add_column :representatives, :zip, :string
    add_column :representatives, :political_party, :string
    add_column :representatives, :photo_url, :string
  end
end
