class Btcaddress < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :address, presence: true

  paginates_per 5
end
