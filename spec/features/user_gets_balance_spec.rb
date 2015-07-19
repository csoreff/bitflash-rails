require 'rails_helper'

feature 'User checks theirs balance', %{
  As an authenticated user
  I want to go to my account page
  And see my current balance
} do

  scenario 'user gets balance' do
    user = FactoryGirl.create(:user)

    sign_in_as(user)
    visit "/account"

    expect(page).to have_content("Balance:")
  end
end
