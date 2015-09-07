class Country < ActiveRecord::Base

  has_many :country_titles, :dependent => :destroy
  has_many :titles , :through => :country_titles

end
