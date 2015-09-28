class UsersController < ApplicationController

  before_filter :set_user, only: [:show, :edit, :update]

  def show
    @user = User.find params[:id]
  end

  def followed_collections
    @collections = current_user.followed_collections
  end

  def add_a_film
    Message.create(author: current_user, message: params[:add_a_film])
    redirect_to(root_path, :notice => "Your message sent to administrator")
  end

  private

    def set_user
      @user = User.find(current_user.id)
    end


end
