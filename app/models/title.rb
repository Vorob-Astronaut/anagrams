class Title < ActiveRecord::Base

  #belongs_to :collection
  has_attached_file :keyArt, :styles => { :medium => "300x300>", :thumb => "100x100#", :custom => "600x338#"}, :default_url => "/noimage/:style/missing.png"
  validates_attachment_content_type :keyArt, :content_type => /\Aimage\/.*\Z/
  has_many :movie_streams
  has_many :country_titles, :dependent => :destroy
  has_many :countries , :through => :country_titles
  has_many :genre_titles, :dependent => :destroy
  has_many :genres , :through => :genre_titles
  has_many :user_favorites
  has_many :user_removals
  has_many :user_queues
  accepts_nested_attributes_for :country_titles, :allow_destroy => true
  accepts_nested_attributes_for :genre_titles, :allow_destroy => true
end
