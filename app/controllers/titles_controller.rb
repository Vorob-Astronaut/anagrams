class TitlesController < ApplicationController


  # GET /titles


  # GET /titles/1
  def show
    @title = Title.friendly.find(params[:id])
  end





end
