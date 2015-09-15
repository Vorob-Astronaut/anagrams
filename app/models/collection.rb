# == Schema Information
#
# Table name: collections
#
#  id                      :integer          not null, primary key
#  date_time               :datetime
#  collection_name         :string(255)
#  collection_description_ :text(65535)
#  user_id                 :string(255)
#  featured                :boolean
#  home                    :boolean
#  image_file_name         :string(255)
#  image_content_type      :string(255)
#  image_file_size         :integer
#  image_updated_at        :datetime
#  is_featured?            :boolean
#  is_home?                :boolean
#

class Collection < ActiveRecord::Base
  extend FriendlyId
  friendly_id :collection_name, use: :slugged

  belongs_to :user
  has_many :notifications, as: :notifier
  has_and_belongs_to_many :followers, class_name: "User", :uniq => true
  has_many :playlists, :dependent => :destroy, after_add: :notify
  has_many :titles , :through => :playlists, after_add: :notify
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100#", :custom => "600x338#"}, :default_url => "/noimage/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  has_many :translations,autosave: true

  TRANSLATED_FIELD = [
    :collection_name, :collection_description_
  ].freeze

  translates *TRANSLATED_FIELD, fallbacks_for_empty_translations: true
  active_admin_translates :collection_name, :collection_description_     do
  end

  accepts_nested_attributes_for :translations
  accepts_nested_attributes_for :playlists, :allow_destroy => true

  after_save :notify

  def follow(user)
    self.followers << user
    self.notifications.build(user: user)
    save!
  end

  def unfollow(user)
    self.followers.delete(user)
    self.notifications.where(user: user).first.destroy
  end

  protected

  def notify(*args)
    self.notifications.each {|n| n.notify("Collection #{self.collection_name} was updated!")}
  end

end
