# frozen_string_literal: true

class NewsItemsController < ApplicationController
  before_action :set_representative
  before_action :set_news_item, only: %i[show destroy]
  before_action :set_news_item_rating, only: %i[show destroy]

  def index
    @news_items = @representative.news_items
    @address = session[:search_address]
  end

  def show; end

  def destroy
    @news_item.destroy
    redirect_to representative_news_items_path(@representative),
                notice: 'News was successfully destroyed.'
  end

  private

  def set_representative
    @representative = Representative.find(
      params[:representative_id]
    )
  end

  def set_news_item_rating
    @rating = Rating.set_your_rating(session[:current_user_id], @news_item.id)
  end

  def set_news_item
    @news_item = NewsItem.find(params[:id])
  end
end
