require 'rails_helper'

feature 'User gets their addresses', %{
  As an authenticated user
  I want to go to my addresses page
  And see all of my btc addresses
  And create new ones
} do

  scenario 'user views their addresses' do
    user = FactoryGirl.create(:user)

    sign_in_as(user)
    visit btcaddresses_path

    expect(page).to have_css('tr#btcaddress')
  end

  # scenario 'user creates new btc address' do
  #   user = FactoryGirl.create(:user)

  #   sign_in_as(user)
  #   visit btcaddresses_path
  #   count = user.btcaddresses.find_each.count
  #   click_link 'Create New Address'
  #   expect(count).to eq(count+1)
  # end
end
