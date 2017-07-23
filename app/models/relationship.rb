class Relationship < ApplicationRecord
  validates :user_id, :presence => true
  validates :target_user_id, :presence => true
  validates_uniqueness_of :user_id, :scope => :target_user_id

  belongs_to :user, foreign_key: 'target_user_id'

  scope :get_friends_emails, lambda { |id|
    select('users.email').joins(:user).where(user_id: id).where(friends: true)
  }
  
  scope :get_common_friends_emails, lambda { |ids|
    select('users.email, count(*) cnt').joins(:user).where(user_id: ids).
    where("users.id NOT IN (?)",ids).where(friends: true).
    group("users.email").
    having("cnt > 1")
  }

  scope :get_updates_emails, lambda { |id|
    select('u.email').joins("INNER JOIN users u on u.id = relationships.user_id").
    where(target_user_id: id).
    where("u.id NOT IN (select target_user_id from relationships where user_id = ? AND block = true)",id)
  }
end