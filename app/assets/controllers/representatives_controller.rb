# frozen_string_literal: true

class RepresentativesController < ApplicationController
  # /representatives
  def index
    @representatives = Representative.all
  end

  # /representatives/:id
  def show
    @representative = Representative.find(params[:id])
    @local = true if params[:local].present? # request came from an internal page
  end
end
