class Relationship < ApplicationRecord
  validates :user_id, :presence => true
  validates :target_user_id, :presence => true
  validates_uniqueness_of :user_id, :scope => :target_user_id

  belongs_to :user, foreign_key: 'target_user_id'

  scope :get_friends_emails, lambda { |id|
    select('users.email').joins(:user).where("relationships.user_id = ?", id)
  }

end
