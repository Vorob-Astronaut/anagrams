class CountriesController < ApplicationController


  # GET /countrytitles
  def index
    @countries = Country.where(is_active?: true)
  end

  # GET /countrytitles/1
  def show
    @country = Country.friendly.find(params[:id])
  end





end
