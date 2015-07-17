class TransactionsController < ApplicationController
  def index
    @transactions = current_user.get_transactions
  end

  def new
    binding.pry
    @friendship = Friendship.find(params[:friendship_id])
    @transaction = Transaction.new
  end

  def create
    @friendship = Friendship.find(params[:friendship_id])
    params[:transaction][:sender_address_id] =
      current_user.btcaddresses.first.id
    params[:transaction][:recipient_address_id] =
      @friendship.friend.btcaddresses.first.id
    friend_address = Btcaddress.find(
      params[:transaction][:recipient_address_id]
    ).address
    amount = params[:transaction][:amount]
    passphrase = params[:transaction][:passphrase]
    new_transaction = current_user.make_btc_payment(
      passphrase,
      friend_address,
      amount
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