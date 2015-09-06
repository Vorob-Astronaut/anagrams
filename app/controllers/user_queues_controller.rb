class UserQueuesController < ApplicationController
  before_action :authenticate_user!

  def add
    @user_queue = UserQueue.where(user_id: current_user.id, title_id: params[:title_id])
    if @user_queue.any? then
      @user_queue.first.destroy
      notice = "Title removed from queue"
    else
      UserQueue.create(user: current_user, title_id: params[:title_id])
      notice = "Title added to queue"
    end
    redirect_to(:back, :notice => notice)
  end

end
