class UserMailer < ApplicationMailer

  def daily_mail(user)
     @user = user
     @notifications = @user.user_log_activities.where("created_at >= ?", Time.zone.now.beginning_of_day)
     mail(to: @user.email, subject: 'Your notifications from butaca') if @notifications.any?
  end

end
