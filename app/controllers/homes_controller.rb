class HomesController < ApplicationController
  def index
    @friendships = current_user.friendships if user_signed_in?
  end
end
