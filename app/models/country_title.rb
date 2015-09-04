class CountryTitle < ActiveRecord::Base
  belongs_to :country
  belongs_to :title
  
end