require 'rails_helper'

feature 'user deletes a friend', %{
  As a user
  I want to be able to delete a friend
  So that they no longer appear on my friends list.
} do

  scenario 'Delete a friend', js: true do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user2)

    sign_in_as(user)
    fill_in 'email', with: user2.email
    click_button 'Go'
    click_link "#{user2.first_name} #{user2.last_name}"
    click_link 'delete-friend'

    page.driver.browser.switch_to.alert.accept

    expect(page).to_not have_content("#{user2.first_name} #{user2.last_name}")
  end
end