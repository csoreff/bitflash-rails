class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => 'User'
  has_many :transactions

  validates :user_id, presence: true, numericality: true
  validates :friend_id, presence: true, numericality: true

  paginates_per 6
end
