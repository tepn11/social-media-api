class Relationship < ApplicationRecord
  validates :user_id, :presence => true
  validates :target_id, :presence => true

  belongs_to :users

end
