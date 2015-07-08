class User < ActiveRecord::Base
  attr_accessor :passphrase

  has_many :friendships
  has_many :addresses
  has_many :friends, :through => :friendships

  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def authenticate_user
    client = Round.client
    client.authenticate_identify(api_token: ENV['ROUND_API_TOKEN'])
    authenticated_user = client.authenticate_device(
      api_token: ENV['ROUND_API_TOKEN'],
      device_token: current_user.device_token,
      email: current_user.email
    )
    authenticated_user.wallet.accounts['default']
  end

  def create_new_address(authenticated_user)
    new_address = authenticated_user.addresses.create
  end

  def make_payment(authenticated_user, password, payee_address, amount)
    authenticated_user.wallet.unlock(password)
    transaction = my_account.pay([{address: payee_address,
      amount: amount}], 1, 'bitflash.herokuapp.com')
  end
end
