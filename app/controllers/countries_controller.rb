class CountriesController < ApplicationController
  add_breadcrumb "home", :root_path
  add_breadcrumb "countries", :countries_path

  # GET /countrytitles
  def index
    @countries = Country.where(is_active?: true)
  end

  # GET /countrytitles/1
  def show
    @country = Country.friendly.find(params[:id])
    @titles = @country.titles-Title.in_removals(current_user)
    add_breadcrumb @country.country, country_path(@country)
  end





end
