class MyDevise::RegistrationsController < Devise::RegistrationsController
  require 'user_helper'
  def create
    params[:user][:device_token] = UserHelper::NewUser.register_new_user(params)
    # Keep original functionality of RegistrationsController
    super
    flash[:notice] = 'Please check your email inbox to confirm your account and complete setup.'
  rescue StandardError
    flash[:warning] = 'You were not registered successfully, please ensure
      all information is correct and that you have not previously registered
      with this email.'
    redirect_to new_user_registration_path
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :device_token)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end
end
