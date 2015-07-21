class HomesController < ApplicationController
  def index
    if user_signed_in?
      if current_user.btcaddresses.empty? && current_user.authenticate_user
        current_user.btcaddresses.create(
          address: current_user.create_new_address
        )
      end
      @friendships = current_user.friendships.page params[:page]
    end
  rescue
    @friendships = current_user.friendships.page params[:page]
    flash[:notice] = 'Please check your email inbox to confirm your account and complete setup.'
  end
end
