# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'json'

class SearchNewsItemsController < ApplicationController
  before_action :set_representative
  before_action :set_issue
  before_action :set_ratings_list, only: %i[search]

  def search
    news_api_key = Rails.application.credentials[:NEWS_API_KEY]
    today_date_str = DateTime.now.to_s[0, 10]
    thirty_days_ago_date_str = (DateTime.now - 30.days).to_s[0, 10]
    news_api_search_query = "#{@representative.name} #{@issue}"
    search_params = { q: news_api_search_query, from: thirty_days_ago_date_str,
              to: today_date_str, sortBy: 'relevancy', apiKey: news_api_key }
    uri = URI.parse('https://newsapi.org/v2/everything')
    # Add params to URI
    uri.query = URI.encode_www_form(search_params)
    response = JSON.parse(Net::HTTP.get(uri))
    @top_5_news_items = NewsItem.news_api_to_news_item_params(response, @issue)
    render 'my_news_items/search'
  end

  def submit
    if params[:selected_news_article].present?
      @news_item = NewsItem.find(params[:selected_news_article])
      @news_item.representative_id = @representative.id # this is the item we choose
      if @news_item.save # copied from the original my_news_items_controller create method
        Rating.handle_rating(session[:current_user_id], @news_item.id, params[:rating])
        redirect_to representative_news_item_path(@representative, @news_item),
                    notice: 'News item was successfully created.'
      else
        render :new, error: 'An error occurred when creating the news item.'
      end
    else
      flash.alert = 'Please select a news article'
      redirect_back fallback_location: { action: 'index' }
    end
  end

  private

  def set_representative
    @representative = Representative.find(
      params[:representative_id]
    )
  end

  def set_issue
    @issue = params[:issue]
  end

  def set_ratings_list
    @ratings_list = [5, 4, 3, 2, 1]
  end
end
