class CollectionsController < ApplicationController


  # GET /collections
  def index
    @collections = Collection.all
  end

  # GET /collections/1
  def show
    @collection = Collection.friendly.find(params[:id])
  end

  def follow
    Collection.friendly.find(params[:id]).follow(current_user) if current_user
    respond_to do |format|
      format.js
    end
  end





end
