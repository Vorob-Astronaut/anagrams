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
    @titles = (@collection.titles-Title.in_removals(current_user)).paginate(page: params[:page], per_page: 5)
    add_breadcrumb @collection.collection_name, collection_path(@collection)
    if request.xhr?
      sleep(3) # make request a little bit slower to see loader
      render :partial => @titles
    end
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
