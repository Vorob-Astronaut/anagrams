# == Schema Information
#
# Table name: titles
#
#  id                        :integer          not null, primary key
#  date_time                 :datetime
#  film_title                :string(255)
#  year_produced             :string(255)
#  snappy_summary            :text(65535)
#  long_description_espanol  :text(65535)
#  key_art                   :text(65535)
#  actors                    :text(65535)
#  director                  :string(255)
#  imdb                      :text(65535)
#  internal_comments         :string(255)
#  butaca_owned              :text(65535)
#  short_description_espanol :text(65535)
#  duration                  :string(255)
#  film_rating               :string(255)
#  active                    :boolean
#  meta_verified             :integer
#  date_updated_can_istream  :datetime
#  key_art_file_name         :string(255)
#  key_art_content_type      :string(255)
#  key_art_file_size         :integer
#  key_art_updated_at        :datetime
#  is_active?                :boolean
#

class Title < ActiveRecord::Base
  extend FriendlyId
  friendly_id :film_title, use: :slugged

  #belongs_to :collection
  has_attached_file :key_art, :styles => { :medium => "300x300>", :thumb => "100x100#", :custom => "600x338#"}, :default_url => "/noimage/:style/missing.png"
  validates_attachment_content_type :key_art, :content_type => /\Aimage\/.*\Z/
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
