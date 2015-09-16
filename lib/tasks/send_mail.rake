namespace :butaca do
  desc "Send daily email"
  task :daily_mail => :environment do
    User.all.each do |u|
      UserMailer.daily_mail(u).deliver_now
    end
  end
end
