class Transaction < ActiveRecord::Base
  attr_accessor :passphrase

  belongs_to :friendship

  validates :friendship_id, presence: true, numericality: true
  validates :sender_address_id, presence: true, numericality: true
  validates :amount, presence: true, numericality: true
  validates :recipient_address_id, presence: true, numericality: true
end
