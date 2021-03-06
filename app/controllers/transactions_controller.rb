class TransactionsController < ApplicationController
  def index
    if current_user.get_transactions.empty?
      flash[:notice] = 'You have no transactions yet.'
      redirect_to root_path
    else
      @transactions = current_user.get_transactions.page params[:page]
    end
  end

  def new
    @btc_price = HTTParty.get('https://www.bitstamp.net/api/ticker/')['last']
    @friendship = Friendship.find(params[:friendship_id])
    @transaction = Transaction.new
    @balance = current_user.get_balance[:balance]
  end

  def create
    new_transaction = current_user.create_transaction(params)
    params = new_transaction[0]
    if new_transaction[1].mfa_uri
      new_transaction[2].transactions.create(transaction_params)
      redirect_to new_transaction[1].mfa_uri
    else
      redirect_to root_path, alert: 'Payment unsuccessful!'
    end
  end

  protected

  def transaction_params
    params.require(:transaction).permit(
      :amount,
      :sender_address_id,
      :recipient_address_id,
      :user_id,
      :recipient_id
    )
  end
end