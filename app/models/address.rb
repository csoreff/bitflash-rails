class Address < ActiveRecord::Base

  belongs_to :user

  validates :user_id, presence: true
  validates :btc_address, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end