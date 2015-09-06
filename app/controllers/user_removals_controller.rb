class UserRemovalsController < ApplicationController
  before_action :authenticate_user!

  def add
    @user_removal = UserRemoval.where(user_id: current_user.id, title_id: params[:title_id])
    if @user_removal.any? then
      @user_removal.first.destroy
      notice = "Title removed from removals"
    else
      UserRemoval.create(user: current_user, title_id: params[:title_id])
      notice = "Title added to removals"
    end
    redirect_to(:back, :notice => notice)
  end

end
