class GenreController < ApplicationController


  # GET /genretitles
   def index
   
     @connection = ActiveRecord::Base.establish_connection(
            :adapter => "mysql2",
            :host => "localhost",
            :database => "butaca_dev",
            :username => "root",
            :password => "1234"
   )
  
     @titles = GenreTitle.all
     @genres = Genre.all
     @countries = Country.where('active' == '["1"]')
   end

  # GET /genretitles/1
  def show
     @connection = ActiveRecord::Base.establish_connection(
            :adapter => "mysql2",
            :host => "localhost",
            :database => "butaca_dev",
            :username => "root",
            :password => "1234"
   )
  
     @titles = GenreTitle.all
     @genres = Genre.find(params[:id])
     @countries = Country.where('active' == '["1"]')
    
  end

 


 
end
