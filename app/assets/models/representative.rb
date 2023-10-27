# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    return [] unless rep_info

    rep_info.officials.each_with_index.map do |official, index|
      create_or_update_representative(official, rep_info.offices, index)
    end
  end

  def self.create_or_update_representative(official, offices, index)
    ocdid, title = fetch_ocdid_and_title(offices, index)
    street, city, state, zip = fetch_address(official)
    reps_with_name_title = Representative.where(name: official.name, title: title) # primary key name and title
    if reps_with_name_title.blank? # if not there, create
      Representative.create(name: official.name, ocdid: ocdid, title: title, street: street, city: city,
                            state: state, zip: zip, political_party: official.party, photo_url: official.photo_url,
                            created_at: DateTime.now, updated_at: DateTime.now)
    elsif reps_with_name_title.count == 1 # if uniquely there, then update
      Representative.update(reps_with_name_title.first.id, name: official.name, ocdid: ocdid, title: title,
                            street: street, city: city, state: state, zip: zip,
                            political_party: official.party, photo_url: official.photo_url,
                            updated_at: DateTime.now)
    else # otherwise, delete all current entries, and reinitialize
      reps_with_name_title.delete_all
      Representative.create(name: official.name, ocdid: ocdid, title: title,
                            street: street, city: city,
                            state: state, zip: zip, political_party: official.party, photo_url: official.photo_url,
                            created_at: DateTime.now, updated_at: DateTime.now)
    end
  end

  def self.fetch_ocdid_and_title(offices, index)
    office = offices.find do |rep|
      rep.official_indices.include? index
    end
    [office.division_id, office.name]
  end

  def self.fetch_address(official)
    return ['', '', '', ''] unless official.address

    address = official.address.first
    [address.line1, address.city, address.state, address.zip]
  end

  # null object pattern: a special rep with name="NULLREP" and
  # title = "NULLREP" represents no representative
  def self.find_or_create_null_rep
    Representative.find_or_create_by!(name: 'NULLREP', title: 'NULLREP')
  end
end
