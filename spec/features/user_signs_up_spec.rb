require 'rails_helper'

feature 'user registers', %{
  As a visitor
  I want to register
  So that I can create an account
} do

  # Acceptance Criteria:
  #   I must specify a valid email address,
  #   password, and password confirmation
  #   If I don't specify the required information, I am presented with
  #   an error message

  scenario 'provide valid registration information' do
    visit new_user_registration_path

    fill_in 'First name', with: 'Bit'
    fill_in 'Last name', with: 'Flash'
    fill_in 'Email', with: "bitflash#{rand(999999999)}@mailinator.com"
    fill_in 'Password', with: 'mybitflash'
    fill_in 'Password confirmation', with: 'mybitflash'
    fill_in 'Passphrase', with: 'passphrase'

    click_button 'Sign up'

    expect(page).to have_content('Please check your email')
    expect(page).to have_content('Sign Out')
  end

  scenario 'provide invalid registration information' do
    visit new_user_registration_path

    click_button 'Sign up'
    expect(page).to have_content("You were not registered successfully")
    expect(page).to_not have_content('Sign Out')
  end
end
