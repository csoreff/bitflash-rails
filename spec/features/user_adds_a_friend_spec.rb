require 'rails_helper'

feature 'user adds a friend', %{
  As a signed up user
  I want to sign in
  And be able to add a friend to my friends list
} do

  scenario 'add a friend' do
    user = FactoryGirl.create(:user)

    sign_in_as(user)

    expect(page).to have_content('Signed in successfully')

    fill_in 'email', with: user.email
    click_button 'Go'

    expect(page).to have_content(user.first_name)
  end
end
