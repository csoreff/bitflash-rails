class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  has_many :transactions

  validates :user_id, presence: true, numericality: true
  validates :friend_id, presence: true, numericality: true
  validates_uniqueness_of :user_id, scope: :friend_id

  paginates_per 4
end
