require 'factory_girl'

FactoryGirl.define do
  factory :user do
    first_name 'Bit'
    last_name 'Flash'
    email 'bitflash276093961@mailinator.com'
    password 'mybitflash'
    password_confirmation 'mybitflash'
    passphrase 'passphrase'
    device_token 'cLoaOOqk8NcODxLA5cG6Y7bKvcK9IaZPkrMGU_MUgP8'
  end
end
