# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  before do
    @state = create(:state)
    @county = create(:county, state: @state)
    @event = create(:event)
  end

  describe 'GET #index' do
    describe 'without filter parameters' do
      it 'assigns all events to @events' do
        get :index
        expect(assigns(:events).to_a).to eq([@event])
      end
    end

    describe 'with filter-by state-only' do
      it 'filters events by state' do
        event_in_state = create(:event, county: @county)
        get :index, params: { 'filter-by' => 'state-only', 'state' => @state.symbol }
        expect(assigns(:events)).to contain_exactly(event_in_state)
      end
    end

    describe 'with filter-by county' do
      it 'filters events by county' do
        event_in_county = create(:event, county: @county)
        get :index, params: { 'filter-by' => 'county', 'state' => @state.symbol, 'county' => @county.fips_code }
        expect(assigns(:events)).to contain_exactly(event_in_county)
      end
    end

    describe 'GET #show' do
      it 'assigns the requested event to @event' do
        get :show, params: { id: @event.id }
        expect(assigns(:event)).to eq(@event)
      end
    end
  end
end
