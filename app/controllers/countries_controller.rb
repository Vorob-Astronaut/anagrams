class CountriesController < ApplicationController


  # GET /countrytitles
  def index
    @countries = Country.where('active' == '["1"]')
  end

  # GET /countrytitles/1
  def show
    @country = Country.find(params[:id])
  end





end
