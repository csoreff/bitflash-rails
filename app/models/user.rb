class User < ActiveRecord::Base
  attr_accessor :passphrase

  has_many :friendships
  has_many :btcaddresses
  has_many :friends, :through => :friendships

  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def authenticate_user(account_type='default')
    client = Round.client
    client.authenticate_identify(api_token: ENV['ROUND_API_TOKEN'])
    authenticated_user = client.authenticate_device(
      api_token: ENV['ROUND_API_TOKEN'],
      device_token: device_token,
      email: email
    )
    authenticated_user.wallet.accounts[account_type]
  end

  def create_new_address(account_type='default')
    new_address = authenticate_user(account_type).addresses.create
    new_address.string
  end

  def get_balance
    balance
  end

  def make_btc_payment(passphrase, payee_address, amount)
    authenticated_user = authenticate_user
    authenticated_user.wallet.unlock(passphrase)
    transaction = authenticated_user.pay([{address: payee_address,
      amount: amount.to_i}], 1, 'https://bitflash.herokuapp.com')
  end

  # make_doge_payment for testing purposes only
  def make_doge_payment(passphrase, payee_address, amount)
    authenticated_user = authenticate_user
    authenticated_user('doge').wallet.unlock(passphrase)
    transaction = pay([{address: payee_address,
      amount: amount.to_i}], 1, 'https://bitflash.herokuapp.com')
  end

  def get_transactions
    authenticate_user.transactions
  end

  def name
    "#{first_name} #{last_name}"
  end

  def non_confirmed_rescue
    rescue
      @friendships = current_user.friendships
      flash[:notice] = 'Please check your email inbox to confirm your account and complete setup.'
  end
end
