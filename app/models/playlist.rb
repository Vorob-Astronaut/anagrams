# == Schema Information
#
# Table name: playlists
#
#  id            :integer          not null, primary key
#  date_time     :datetime
#  collection_id :integer
#  title_id      :integer
#

class Playlist < ActiveRecord::Base

  belongs_to :collection
  belongs_to :title
  after_create :notify

  protected

  def notify(*args)
    self.collection.notifications.each {|n| n.notify("A new film added to collection #{self.collection.collection_name}")}
  end

end
