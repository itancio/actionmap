# frozen_string_literal: true

class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :news_item

  # saves or updates a rating for a given user and news item
  def self.handle_rating(u_id, news_id, rating)
    rating_entry = Rating.where(user_id: u_id, news_item_id: news_id).first_or_initialize
    rating_entry.rating = rating
    rating_entry.save!
  end

  # returns rating if user is logged in, else the string "N/A (not logged in)"
  def self.set_your_rating(u_id, news_id)
    if u_id.nil?
      'N/A (not logged in)'
    else
      rating_entry = Rating.where(user_id: u_id, news_item_id: news_id).first
      return rating_entry.rating unless rating_entry.nil?
    end
  end
end
