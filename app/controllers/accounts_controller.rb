class AccountsController < ApplicationController
  def index
    @balance = current_user.get_balance[:balance]
    @pending_balance = current_user.get_balance[:pending_balance]
  end

  def new
    @btc_price = HTTParty.get('https://www.bitstamp.net/api/ticker/')['last']
    @balance = current_user.get_balance[:balance]
  end

  def create
    amount = params[:amount].to_f * 100_000_000.to_f
    new_transaction = current_user.make_btc_payment(
      params[:passphrase],
      params[:btcaddress],
      amount
    )
    if new_transaction.mfa_uri
      redirect_to new_transaction.mfa_uri
    else
      redirect_to root_path, alert: 'Payment unsuccessful!'
    end
  end
end
