module UserHelper
  class NewUser
    def self.register_new_user(params)
      binding.pry
      client = Round.client
      client.authenticate_identify(api_token: ENV['ROUND_API_TOKEN'])
      params[:user][:device_token] = client.users.create(
        first_name: params[:user][:first_name],
        last_name: params[:user][:last_name],
        email: params[:user][:email],
        passphrase: params[:user][:passphrase],
        device_name: "device#{rand(99999)}",
        redirect_uri: 'https://bitflash.herokuapp.com'
      )
    end
  end
end
