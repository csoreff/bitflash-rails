require 'factory_girl'

FactoryGirl.define do
  factory :user do
    first_name 'Bit'
    last_name 'Flash'
    email 'bitflashvcr@gmail.com'
    password 'mybitflash'
    password_confirmation 'mybitflash'
    passphrase 'This is a passphrase'
    device_token 'GH1746492FJDGLD'
  end
end
