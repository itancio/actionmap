# frozen_string_literal: true

require 'google/apis/civicinfo_v2'

class SearchController < ApplicationController
  def search
    service = Google::Apis::CivicinfoV2::CivicInfoService.new
    service.key = Rails.application.credentials[:GOOGLE_API_KEY]
    if params[:address] == '' # case where address is empty
      flash.alert = 'Address cannot be blank'
      redirect_back fallback_location: { action: 'index' }
    else
      begin
        result = service.representative_info_by_address(address: params[:address])
      rescue Google::Apis::ClientError # case where address is invalid
        flash.alert = 'Invalid Address'
        return redirect_back fallback_location: { action: 'index' }
      end
      @representatives = Representative.civic_api_to_representative_params(result)
      session[:search_address] = params[:address] # this is necessary for back button functionality
      do_search_redirect_or_render
    end
  end

  private

  def do_search_redirect_or_render
    if params[:state_symbol].present? # means the request came from the map, so redirect to map controller
      redirect_to county_path(state_symbol: params[:state_symbol], std_fips_code: params[:std_fips_code],
                              representatives: @representatives)
    else # otherwise render the default search
      render 'representatives/search'
    end
  end
end
