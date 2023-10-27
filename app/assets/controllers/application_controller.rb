# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticated
  before_action :set_current_user

  private

  def authenticated
    @authenticated = !session[:current_user_id].nil?
  end

  def set_current_user
    @current_user = User.find(session[:current_user_id]) and return \
        if session[:current_user_id].present?
  end
end
