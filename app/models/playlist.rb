class Playlist < ActiveRecord::Base
  
  belongs_to :collection
  belongs_to :title

end