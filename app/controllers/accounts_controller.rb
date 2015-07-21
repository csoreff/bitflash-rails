class AccountsController < ApplicationController
  def index
    @friendships = current_user.friendships.page params[:page]
    @balance = current_user.authenticate_user.balance
    @pending_balance = current_user.authenticate_user.pending_balance
  rescue
    @friendships = current_user.friendships.page params[:page]
    flash[:notice] = 'Please check your email inbox to confirm your account and complete setup.'
    redirect_to root_path
  end
end
