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

end
