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
  ratyrate_rateable "users_score"

  #belongs_to :collection
  has_attached_file :key_art, :styles => { :medium => "300x300>", :thumb => "50x50#", :custom => "694x1000#"}, :default_url => "/noimage/:style/missing.png"
  validates_attachment_content_type :key_art, :content_type => /\Aimage\/.*\Z/
  has_many :movie_streams, after_add: :notify
  has_many :notifications, as: :notifier
  has_many :country_titles, :dependent => :destroy
  has_many :countries , :through => :country_titles
  has_many :genre_titles, :dependent => :destroy
  has_many :genres , :through => :genre_titles
  has_many :user_favorites
  has_many :user_removals
  has_many :user_queues
  accepts_nested_attributes_for :country_titles, :allow_destroy => true
  accepts_nested_attributes_for :genre_titles, :allow_destroy => true


  def self.in_removals(user)
    if user then
      includes(:user_removals).where(:user_removals => {user_id: user.id})
    else
      return []
    end
  end

  def follow(user)
    self.notifications.build(user: user)
    save!
  end

  def unfollow(user)
    self.notifications.where(user: user).first.destroy
    save!
  end

  def check_sources(client)
    self.movie_streams.each {|s| s.destroy! if s.protect != true}
    response = client.search_and_query(self.film_title, ['streaming', 'rental', 'purchase', 'dvd', 'xfinity']).first
    if response
      ['streaming', 'rental', 'purchase', 'dvd', 'xfinity'].each do |type|
        response["availability"][type].each do |source|
          if source.first != "amazon_bluray" then
            if source.first != "netflix_dvd" then
              stream_type = MovieStreamLinkType.find_by_typel(source.first)
              if stream_type == nil then
                stream_type = MovieStreamLinkType.create(typel: source.first)
                Message.create(message: "NEW STREAM TYPE #{stream_type.typel} ADDED. PLEASE, ADD A LOGO MANUALY")
              end
              self.movie_streams.create(typel: type, link: source.last["direct_url"], movie_stream_link_type: stream_type, price: source.last["price"], external_id: source.last["external_id"] || 0)
            end
          end
        end
      end
    end
  end

  def image
    key_art
  end

  protected

  def notify(*args)
    self.notifications.each {|n| n.notify("A new platform added to title #{self.film_title}")}
  end

end
