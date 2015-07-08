class MyDevise::RegistrationsController < Devise::RegistrationsController
  def create
    client = Round.client
    first_name = params[:user][:first_name]
    last_name = params[:user][:last_name]
    email = params[:user][:email]
    password = params[:user][:password]
    passphrase = params[:user][:passphrase]
    client.authenticate_identify(api_token: ENV['ROUND_API_TOKEN'])
    params[:user][:device_token] = client.users.create(
      first_name: first_name,
      last_name: last_name,
      email: email,
      passphrase: passphrase,
      device_name: "device",
      redirect_uri: 'https://bitflash.herokuapp.com'
    )
    # Keep original functionality of RegistrationsController, just add to it
    super unless :device_token.nil?
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :device_token)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end
end
