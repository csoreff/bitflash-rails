require 'factory_girl'

FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name 'Smith'
    sequence(:email) {|n| "user#{n*rand(9999999)}@example.com" }
    password 'password'
    password_confirmation 'password'
    passphrase 'This is a passphrase'
  end

end
