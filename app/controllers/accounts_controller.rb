class AccountsController < ApplicationController
  def index
    @balance = current_user.authenticate_user.balance
    @pending_balance = current_user.authenticate_user.pending_balance
  end
end
