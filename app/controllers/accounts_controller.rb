class AccountsController < ApplicationController
  def index
    @balance = current_user.get_balance
    @pending_balance = current_user.get_pending_balance
  end
end
