class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :get_friends
  around_action :rescue_unconfirmed_users


  def get_friends
    if user_signed_in?
      @friendships = current_user.friendships.page params[:page]
    end
  end

  def rescue_unconfirmed_users
    begin
      yield
    rescue
      @friendships = current_user.friendships.page params[:page]
      flash[:notice] = 'Please check your email inbox to confirm
        your account and complete setup.'
      redirect_to root_path
    end
  end
end
