# frozen_string_literal: true

class MyNewsItemsController < SessionController
  before_action :set_representative
  before_action :set_representatives_list
  before_action :set_issues_list
  before_action :set_ratings_list
  before_action :set_news_item, only: %i[edit update]
  before_action :set_news_item_rating, only: %i[edit update]

  def new
    @news_item = NewsItem.new
  end

  def edit; end

  def update
    if @news_item.update(news_item_params)
      Rating.handle_rating(session[:current_user_id], @news_item.id, params[:rating])
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully updated.'
    else
      render :edit, error: 'An error occurred when updating the news item.'
    end
  end

  private

  def set_representative
    @representative = Representative.find(
      params[:representative_id]
    )
  end

  def set_representatives_list
    @representatives_list = Representative.all.map { |r| [r.name, r.id] }
  end

  def set_issues_list
    @issues_list = ['Free Speech', 'Immigration', 'Terrorism', 'Social Security and Medicare', 'Abortion',
                    'Student Loans', 'Gun Control', 'Unemployment', 'Climate Change', 'Homelessness', 'Racism',
                    'Tax Reform', 'Net Neutrality', 'Religious Freedom', 'Border Security', 'Minimum Wage', 'Equal Pay']
  end

  def set_news_item
    @news_item = NewsItem.find(params[:id])
  end

  def set_news_item_rating
    @rating = Rating.set_your_rating(session[:current_user_id], @news_item.id)
  end

  def set_ratings_list
    @ratings_list = [5, 4, 3, 2, 1]
  end

  # Only allow a list of trusted parameters through.
  def news_item_params
    params.require(:news_item).permit(:news, :title, :description, :link, :representative_id, :issue)
  end
end
