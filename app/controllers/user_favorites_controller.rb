class UserFavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_favorites = current_user.user_favorites
  end

  def add
    @user_favorites = UserFavorite.where(user_id: current_user.id, title_id: params[:title_id])
    if @user_favorites.any? then
      @user_favorites.first.destroy
      notice = "Title removed from favorites"
    else
      UserFavorite.create(user: current_user, title_id: params[:title_id])
      notice = "Title added to favorites"
    end
    respond_to do |format|
      format.js
      format.html {redirect_to(:back, :notice => notice) }
    end
  end

end
