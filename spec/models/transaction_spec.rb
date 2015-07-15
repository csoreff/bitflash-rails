require 'rails_helper'

describe Transaction do
  it { should belong_to :friendship }

  it { should have_valid(:friendship_id).when(1) }
  it { should_not have_valid(:friendship_id).when(nil) }

  it { should have_valid(:sender_address_id).when(1) }
  it { should_not have_valid(:sender_address_id).when(nil) }

  it { should have_valid(:amount).when(100) }
  it { should_not have_valid(:amount).when(nil) }

  it { should have_valid(:recipient_address_id).when(1) }
  it { should_not have_valid(:recipient_address_id).when(nil) }
end
