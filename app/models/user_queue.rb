class UserQueue < ActiveRecord::Base
  validates :user_id, uniqueness: { scope: :title_id }

  belongs_to :user
  belongs_to :title
end
