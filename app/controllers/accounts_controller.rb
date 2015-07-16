class AccountsController < ApplicationController
  def index
    @balance = current_user.authenticate_user.balance
  end
end
