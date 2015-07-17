require 'rails_helper'

feature 'User has a transaction', %{
  As an authenticated user
  I want to select a friend
  And send them a payment
  And also receive payments
} do

  scenario 'User sends a payment' do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user2)

    sign_in_as(user)
    fill_in 'email', with: user2.email
    click_button 'Go'
    click_link "#{user2.first_name} #{user2.last_name}"
    click_link 'send-money'

  end

  scenario 'user receives a payment' do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user2)

    sign_in_as(user)
    fill_in 'email', with: user2.email
    click_button 'Go'

    expect(page).to have_content(user2.first_name)
  end
end