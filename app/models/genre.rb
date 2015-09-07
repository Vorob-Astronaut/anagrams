class Genre < ActiveRecord::Base
  
  has_many :genre_titles, :dependent => :destroy
  has_many :titles, :through => :genre_titles


end
