class User < ApplicationRecord
  attribute :email, :string
  validates :email, :presence => true, uniqueness: true, :format => { :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, :message => 'Invalid email format' }

  has_many :relationships, dependent: :destroy 

end
