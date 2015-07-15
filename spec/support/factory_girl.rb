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

  factory :user2, class: User do
    first_name 'Bit'
    last_name 'Flash'
    email 'bitflash72281815@mailinator.com'
    password 'mybitflash'
    password_confirmation 'mybitflash'
    passphrase 'passphrase'
    device_token '4GkiGBWOBU6Bjeh6ptSXSeTFNkFyaluQQkHIRfZ3h2M'
  end
end
