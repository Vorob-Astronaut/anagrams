class CollectionsController < ApplicationController


  # GET /collections
  def index
    @collections = Collection.all
  end

  # GET /collections/1
  def show
    @collection = Collection.find(params[:id])
  end





end
