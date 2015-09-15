class UserLogActivity < ActiveRecord::Base
  belongs_to :user
  belongs_to :notification

  after_save :notify

  protected

  def notify
    redis = Redis.new
    redis.publish "crier:transitions", self.message
  end

end
