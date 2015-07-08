require 'rails_helper'

describe Address do
  it { should belong_to :user }

  it { should have_valid(:user_id).when(1) }
  it { should_not have_valid(:user_id).when(nil) }

  it { should have_valid(:btc_address).when("KKDBF4958272JDJHDJW") }
  it { should_not have_valid(:btc_address).when(nil) }
end