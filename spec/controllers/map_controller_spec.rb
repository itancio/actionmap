# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MapController, type: :controller do
  describe 'GET #index' do
    it 'assigns all states as @states' do
      state = create(:state)
      get :index
      expect(assigns(:states)).to eq([state])
    end
  end

  describe 'GET #state' do
    describe 'when state is found' do
      it 'assigns the requested state as @state' do
        state = create(:state, symbol: 'CA')
        get :state, params: { state_symbol: 'CA' }
        expect(assigns(:state)).to eq(state)
      end
    end

    describe 'when state is not found' do
      it 'redirects to the root path with an alert' do
        get :state, params: { state_symbol: 'ZZ' }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("State 'ZZ' not found.")
      end
    end
  end

  describe 'GET #county' do
    before do
      @state = create(:state, symbol: 'CA')
      @county = create(:county, state: @state, fips_code: 123)
      @representative = create(:representative)
    end

    describe 'when state and county are found' do
      it 'assigns the requested county as @county' do
        get :county, params: { state_symbol: 'CA', std_fips_code: '123', representatives: [@representative.id] }
        expect(assigns(:county)).to eq(@county)
      end
    end

    describe 'when state is not found' do
      it 'redirects to the root path with an alert' do
        get :county, params: { state_symbol: 'ZZ', std_fips_code: '123' }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("State 'ZZ' not found.")
      end
    end
  end
end
