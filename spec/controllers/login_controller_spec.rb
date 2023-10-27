# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LoginController, type: :controller do
  describe 'GET #logout' do
    before do
      # Create a user and set it as the current user
      @user = User.create(uid: '123', provider: 'google_oauth2', first_name: 'Test', last_name: 'User',
                          email: 'test@example.com')
      session[:current_user_id] = @user.id
    end

    it 'logs out the current user and redirects to the root path' do
      get :logout
      expect(session[:current_user_id]).to be_nil
      expect(response).to redirect_to(root_path)
    end
  end
end
