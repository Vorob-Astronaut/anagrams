class MovieStreamLinkType < ActiveRecord::Base
  has_many :movie_stream

  has_attached_file :logo, :styles => { :medium => "100x200>" }, :default_url => "/noimage/:style/missing.png"
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/


end
