class TransactionsController < ApplicationController
  def index
    @friendships = current_user.friendships
    @transactions = current_user.get_transactions
  rescue
    @friendships = current_user.friendships
    flash[:notice] = 'Please check your email inbox to confirm your account and complete setup.'
    redirect_to root_path
  end

  def new
    @friendships = current_user.friendships
    @friendship = Friendship.find(params[:friendship_id])
    @transaction = Transaction.new
    @balance = current_user.authenticate_user.balance
  rescue
    @friendships = current_user.friendships
    flash[:notice] = 'Please check your email inbox to confirm your account and complete setup.'
    redirect_to root_path
  end

  def create
    new_transaction = current_user.create_transaction(params)
    params = new_transaction[0]
    if new_transaction[1].mfa_uri
      new_transaction[2].transactions.create(transaction_params)
      redirect_to new_transaction[1].mfa_uri
    else
      redirect_to root_path, alert: "Payment unsuccessful!"
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