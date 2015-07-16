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
      device_token: device_token,
      email: email
    )
    authenticated_user.wallet.accounts['default']
  end

  def create_new_address
    new_address = addresses.create
    addresses.new(btc_addess: new_address)
  end

  def get_balance
    balance
  end

  def make_payment(passphrase, payee_address, amount)
    wallet.unlock(passphrase)
    transaction = pay([{address: payee_address,
      amount: amount}], 1, 'bitflash.herokuapp.com')
  end

  def name
    "#{first_name} #{last_name}"
  end
end
