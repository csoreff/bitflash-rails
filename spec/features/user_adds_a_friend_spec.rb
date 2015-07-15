require 'rails_helper'

feature 'user adds a friend', %{
  As a signed up user
  I want to sign in
  And be able to add a friend to my friends list
} do

  scenario 'add a friend' do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user2)

    sign_in_as(user)
    fill_in 'email', with: user2.email
    click_button 'Go'

    expect(page).to have_content(user2.first_name)
  end
end
