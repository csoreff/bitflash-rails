class TransactionsController < ApplicationController

  def new
    @friendship = Friendship.find(params[:friendship_id])
    @transaction = Transaction.new
  end

  def create
    current_user.authenticate_user
    @friendship = Friendship.find(params[:friendship_id])
    params[:transactions][:sender_address_id] = current_user.addresses.first
    params[:transactions][:recipient_address_id] =
    amount =
    @transaction = @friendship.transactions.new(transaction_params)
    @review.user = current_user
    # @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    # if @friendship.save
    #   flash[:notice] = "Friend added."
    #   redirect_to root_url
    # else
    #   flash[:error] = "Unable to add friend."
    #   redirect_to root_url
    # end
  end

  protected

  def review_params
    params.require(:transaction).permit(:amount, :sender_address_id, :recipient_address_id)
  end
end