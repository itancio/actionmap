# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserController, type: :controller do
  describe 'GET #profile' do
    before do
      @user = create(:user)
      session[:current_user_id] = @user.id
    end

    it 'assigns the logged-in user to @user' do
      get :profile
      expect(assigns(:user)).to eq(@user)
    end

    it 'renders the profile template' do
      get :profile
      expect(response).to render_template(:profile)
    end
  end
end
