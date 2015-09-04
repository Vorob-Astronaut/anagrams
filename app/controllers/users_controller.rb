class UsersController < ApplicationController

  before_filter :set_user, only: [:show, :edit, :update]

  def show
  end

  
  
  private

    def set_user
      @user = User.find(current_user.id)
    end


end
