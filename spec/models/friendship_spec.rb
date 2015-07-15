require 'rails_helper'

describe Friendship do
  it { should belong_to :user }
  it { should belong_to :friend }

  it { should have_valid(:user_id).when(1) }
  it { should_not have_valid(:user_id).when(nil) }

  it { should have_valid(:friend_id).when(1) }
  it { should_not have_valid(:friend_id).when(nil) }
end
