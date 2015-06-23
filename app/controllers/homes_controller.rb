class HomesController < ApplicationController
  def index
    @friendships = current_user.friendships if current_user
  end
end
