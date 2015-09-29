class MessagesController < ApplicationController

  def report
    @message = Message.new
    render :layout => false
  end

  def create
    Message.create(author: User.find_by_email(params[:message][:author]), message: "USER REPORT A PROBLEM WITH TITLE #{params[:message][:title]} MESSAGE: #{params[:message][:message]}")
    redirect_to :back
  end

end
