class CollectionsController < ApplicationController
  add_breadcrumb "home", :root_path
  add_breadcrumb "collections", :collections_path

  # GET /collections
  def index
    @collections = Collection.all
  end

  # GET /collections/1
  def show
    @collection = Collection.friendly.find(params[:id])
    add_breadcrumb @collection.collection_name, collection_path(@collection)
  end

  def follow
    if current_user
      @collection = Collection.friendly.find(params[:id])
      if @collection.followers.where(id: current_user.id).any? then
        @collection.unfollow(current_user)
      else
        @collection.follow(current_user)
      end
    end
    respond_to do |format|
      format.js
    end
  end





end
