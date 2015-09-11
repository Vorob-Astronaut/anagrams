class UserQueuesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_queues = current_user.user_queues
  end

  def add
    @user_queue = UserQueue.where(user_id: current_user.id, title_id: params[:title_id])
    if @user_queue.any? then
      @user_queue.first.destroy
      notice = "Title removed from queue"
    else
      UserQueue.create(user: current_user, title_id: params[:title_id])
      notice = "Title added to queue"
    end
    respond_to do |format|
      format.js
      format.html {redirect_to(:back, :notice => notice) }
    end
  end

end
