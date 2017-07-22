class Relationship < ApplicationRecord
  validates :user_id, :presence => true
  validates :target_user_id, :presence => true
  validates_uniqueness_of :user_id, :scope => :target_user_id

  belongs_to :user
end
