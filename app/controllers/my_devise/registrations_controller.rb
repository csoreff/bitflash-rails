class MyDevise::RegistrationsController < Devise::RegistrationsController
  # class GemUser
  #   include ActiveModel::ActiveModel
  #   validates :first_name, presence: true
  #   validates :last_name, presence: true

  #   def save
  #     client.authenticate_identify(api_token: ENV['ROUND_API_TOKEN'])
  #     if user = client.users.find
  #     else
  #       client.users.create(first_name: self.first_name, ...)
  #     end
  #   end
  # end
  def create
    client = Round.client
    client.authenticate_identify(api_token: ENV['ROUND_API_TOKEN'])
    # allow(client.users).to_receive(:create)
    params[:user][:device_token] = client.users.create(
      first_name: params[:user][:first_name],
      last_name: params[:user][:last_name],
      email: params[:user][:email],
      passphrase: params[:user][:passphrase],
      device_name: "device#{rand(99999)}",
      redirect_uri: 'https://bitflash.herokuapp.com'
    )
    # Keep original functionality of RegistrationsController
    super
  rescue StandardError
    flash[:warning] = 'You were not registered successfully, please ensure all information is correct and that you have not previously registered with this email.'
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
