# frozen_string_literal: true

class MapController < ApplicationController
  # Render the map of the United States.
  def index
    @states = State.all
    @states_by_fips_code = @states.index_by(&:std_fips_code)
  end

  # Render the map of the counties of a specific state.
  def state
    @state = State.find_by(symbol: params[:state_symbol].upcase)
    handle_state_not_found && return if @state.nil?

    @county_details = @state.counties.index_by(&:std_fips_code)
  end

  # Render the map of a specific county.
  def county
    @state = State.find_by(symbol: params[:state_symbol].upcase)
    handle_state_not_found && return if @state.nil?

    @county = get_requested_county @state.id
    handle_county_not_found && return if @state.nil?

    ids = params[:representatives] # this will be a list of ids
    if ids.nil? # if user tried to go directly to link w/o clicking map
      return redirect_to search_representatives_path(address: @county.name, state_symbol: params[:state_symbol],
                                                     std_fips_code: params[:std_fips_code]) # redirect to search
    end
    @representatives = Representative.where(id: ids)
    @county_details = @state.counties.index_by(&:std_fips_code)
  end

  private

  def handle_state_not_found
    state_symbol = params[:state_symbol].upcase
    redirect_to root_path, alert: "State '#{state_symbol}' not found."
  end

  def handle_county_not_found
    state_symbol = params[:state_symbol]
    std_fips_code = params[:std_fips_code]
    redirect_to root_path, alert: "County with code '#{std_fips_code}' not found for #{state_symbol}"
  end

  def get_requested_county(state_id)
    County.find_by(
      state:     state_id,
      fips_code: params[:std_fips_code].to_i(10)
    )
  end
end
