class User < ActiveRecord::Base
  attr_accessor :passphrase

  has_many :friendships
  has_many :btcaddresses
  has_many :transactions
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
    authenticated_user = authenticate_user
    authenticated_user.balance.to_f / 100_000_000.to_f
  end

  def get_pending_balance
    authenticated_user = authenticate_user
    authenticated_user.pending_balance.to_f / 100_000_000.to_f
  end

  def make_btc_payment(passphrase, payee_address, amount)
    authenticated_user = authenticate_user
    authenticated_user.wallet.unlock(passphrase)
    transaction = authenticated_user.pay([{address: payee_address,
      amount: amount.to_i}], 1, 'https://bitflash.herokuapp.com')
  end

  def get_transactions
    Transaction.where(
      Transaction.arel_table[:user_id].in(id).or(
        Transaction.arel_table[:recipient_id].in(id)
      )
    ).order(created_at: :desc)
  end

  def create_transaction(params)
    @friendship = Friendship.find(params[:friendship_id])
    params[:transaction][:sender_address_id] =
      btcaddresses.order('created_at DESC').first.id
    params[:transaction][:recipient_address_id] =
      @friendship.friend.btcaddresses.order('created_at DESC').first.id
    params[:transaction][:user_id] = id
    params[:transaction][:recipient_id] = @friendship.friend.id
    friend_address = Btcaddress.find(
      params[:transaction][:recipient_address_id]
    ).address
    amount = params[:amount].to_f * 100_000_000.to_f
    new_payment = make_btc_payment(
      params[:transaction][:passphrase],
      friend_address,
      amount
    )
    [params, new_payment, @friendship]
  end

  def name
    "#{first_name} #{last_name}"
  end
end
