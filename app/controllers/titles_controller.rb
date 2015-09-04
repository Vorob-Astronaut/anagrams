class TitlesController < ApplicationController


  # GET /titles
 

  # GET /titles/1
  def show
    @title = Title.find(params[:id])
    
  end

 


 
end

