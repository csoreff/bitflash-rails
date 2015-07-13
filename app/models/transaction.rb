class Transaction < ActiveRecord::Base
  belongs_to :friendship

  validates :user_id, presence: true, numericality: true
  validates :address_id, presence: true, numericality: true
  validates :amount, presence: true, numericality: true
  validates :recipient_address_id, presence: true, numericality: true
  validates :recipient_user_id, presence: true, numericality: true
end