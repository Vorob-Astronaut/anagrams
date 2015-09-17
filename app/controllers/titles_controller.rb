class TitlesController < ApplicationController
  add_breadcrumb "home", :root_path

  # GET /titles


  # GET /titles/1
  def show
    @title = Title.friendly.find(params[:id])
    add_breadcrumb @title.film_title, title_path(@title)
  end


  def follow
    if current_user
      @title = Title.friendly.find(params[:id])
      if @title.notifications.where(user: current_user).any? then
        @title.unfollow(current_user)
      else
        @title.follow(current_user)
      end
    end
    respond_to do |format|
      format.js
    end
  end


end
