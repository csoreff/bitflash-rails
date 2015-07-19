class TransactionsController < ApplicationController
  def index
    @friendships = current_user.friendships
    @transactions = current_user.get_transactions
  end

  def new
    @friendships = current_user.friendships
    @friendship = Friendship.find(params[:friendship_id])
    @transaction = Transaction.new
  end

  def create
    @friendship = Friendship.find(params[:friendship_id])
    params[:transaction][:sender_address_id] =
      current_user.btcaddresses.order('created_at DESC').first.id
    params[:transaction][:recipient_address_id] =
      @friendship.friend.btcaddresses.order('created_at DESC').first.id
    friend_address = Btcaddress.find(
      params[:transaction][:recipient_address_id]
    ).address
    new_transaction = current_user.make_btc_payment(
      params[:transaction][:passphrase],
      friend_address,
      params[:transaction][:amount]
    )
    if new_transaction.mfa_uri
      @friendship.transactions.create(transaction_params)
      redirect_to new_transaction.mfa_uri
    else
      redirect_to root_path, alert: "Payment unsuccessful!"
    end
  end

  protected

  def transaction_params
    params.require(:transaction).permit(:amount, :sender_address_id, :recipient_address_id)
  end
end