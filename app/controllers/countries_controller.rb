class CountriesController < ApplicationController


  # GET /countrytitles
  def index
    @countries = Country.where('active' == '["1"]')
  end

  # GET /countrytitles/1
  def show
    @titles = CountryTitle.find_by_title_id(params[:id])
     @connection = ActiveRecord::Base.establish_connection(
            :adapter => "mysql2",
            :host => "localhost",
            :database => "butaca_dev",
            :username => "root",
            :password => "1234"
   )


     @countries = Country.where('active' == '["1"]')
      @genres = Genre.all
  end





end