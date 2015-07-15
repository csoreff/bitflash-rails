require 'rails_helper'

feature 'logged in user sees different homepage', %{
  As a logged in user
  I want to visit the homepage
  And see my friends list
} do

  scenario 'logged in user sees friends list on homepage' do
    user = FactoryGirl.create(:user)

    sign_in_as(user)

    expect(page).to have_content('Add a New Friend')
    expect(page).to_not have_content('The easiest way to send funds worldwide.')
  end
end
