require 'rails_helper'

feature 'User has a transaction', %{
  As an authenticated user
  I want to select a friend
  And send them a payment
  And also receive payments
  And be able to withdraw my funds
} do

  scenario 'User sends a payment', js: true do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user2)
    FactoryGirl.create(:btcaddress)
    FactoryGirl.create(:btcaddress2)

    sign_in_as(user)
    fill_in 'email', with: user2.email
    click_button 'Go'
    click_link "#{user2.first_name} #{user2.last_name}"
    click_link 'Send Money'
    fill_in 'Amount', with: 0.0005
    fill_in 'Passphrase', with: user.passphrase
    click_button 'Submit'
    page.driver.browser.switch_to.alert.accept
    # Sleep while receiving 2FA code from cell phone and enter it in browser
    sleep 30

    expect(user.authenticate_user.pending_balance).not_to eq(0)
    expect(user2.authenticate_user.pending_balance).not_to eq(0)
  end

  scenario 'User makes a withdrawal', js: true do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user2)
    FactoryGirl.create(:btcaddress)
    FactoryGirl.create(:btcaddress2)

    sign_in_as(user)
    visit account_withdraw_path
    fill_in 'Bitcoin Address', with: user2.btcaddresses.first.address
    fill_in 'Amount', with: 0.0005
    fill_in 'Passphrase', with: user.passphrase
    click_button 'Submit'
    page.driver.browser.switch_to.alert.accept
    # Sleep while receiving 2FA code from cell phone and enter it in browser
    sleep 30

    expect(user.authenticate_user.pending_balance).not_to eq(0)
    expect(user2.authenticate_user.pending_balance).not_to eq(0)
  end
end
