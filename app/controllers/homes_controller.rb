class HomesController < ApplicationController
  def index
    if user_signed_in?
      if current_user.btcaddresses.first.nil? && current_user.authenticate_user
        current_user.btcaddresses.create(
          address: current_user.create_new_address
        )
      end
      @friendships = current_user.friendships
    end
  end
end
