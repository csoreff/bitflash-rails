class BtcaddressesController < ApplicationController
  def index
    @addresses = current_user.addresses.order(created_at: :desc)
  end

  def create
    new_address = current_user.create_new_address
    if new_address.save
      flash[:notice] = "New BTC address created."
      redirect_to addresses_path
    else
      flash[:error] = "Unable to create new BTC address."
      redirect_to addresses_path
    end
  end
end
