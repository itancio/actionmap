# frozen_string_literal: true

class NewsItem < ApplicationRecord
  belongs_to :representative
  has_many :ratings, dependent: :delete_all

  def self.find_for(representative_id)
    NewsItem.find_by(
      representative_id: representative_id
    )
  end

  # builds and returns the top 5 search results from the
  # JSON response from the API
  def self.news_api_to_news_item_params(response, iss)
    all_articles = response['articles']
    if all_articles.present?
      top_five = all_articles[0, 5]
      top_five.each.map do |article|
        # we don't want to add to the rep's list of articles yet, but do want to persist it
        NewsItem.find_or_create_by!(issue: iss, title: article['title'],
                                    representative_id: Representative.find_or_create_null_rep.id,
                                    description: article['description'], link: article['url'])
      end
    else
      []
    end
  end
end
