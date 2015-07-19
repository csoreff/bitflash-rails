class AccountsController < ApplicationController
  def index
    @friendships = current_user.friendships
    @balance = current_user.authenticate_user.balance
    @pending_balance = current_user.authenticate_user.pending_balance
  end
end
