class BtcaddressesController < ApplicationController
  def index
    @friendships = current_user.friendships
    @btcaddresses = current_user.btcaddresses.order(created_at: :desc)
  rescue
    @friendships = current_user.friendships
    flash[:notice] = 'Please check your email inbox to confirm your account and complete setup.'
    redirect_to root_path
  end

  def create
    new_address = current_user.btcaddresses.new(
      address: current_user.create_new_address
    )
    if new_address.save
      flash[:notice] = "New BTC address created."
      redirect_to btcaddresses_path
    else
      flash[:error] = "Unable to create new BTC address."
      redirect_to btcaddresses_path
    end
  end
end
