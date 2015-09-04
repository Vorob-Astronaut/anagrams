class Collection < ActiveRecord::Base
  
  
  belongs_to :user
  has_many :playlists, :dependent => :destroy 
  has_many :titles , :through => :playlists
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
  
end