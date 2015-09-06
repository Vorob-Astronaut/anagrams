class UserFavoritesController < ApplicationController
  before_action :authenticate_user!

  def add
    @user_favorites = UserFavorite.where(user_id: current_user.id, title_id: params[:title_id])
    if @user_favorites.any? then
      @user_favorites.first.destroy
      notice = "Title removed from favorites"
    else
      UserFavorite.create(user: current_user, title_id: params[:title_id])
      notice = "Title added to favorites"
    end
    redirect_to(:back, :notice => notice)
  end

end
