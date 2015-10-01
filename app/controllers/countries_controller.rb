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
    @titles = (@country.titles-Title.in_removals(current_user)).paginate(page: params[:page], per_page: 6)
    add_breadcrumb @country.country, country_path(@country)
    if request.xhr?
      sleep(3) # make request a little bit slower to see loader
      render :partial => @titles
    end
  end





end
