require 'rails_helper'

describe Friendship do
  it { should belong_to :user }
  it { should belong_to :friend }

  it { should have_many(:transactions) }

  it { should have_valid(:user_id).when(1) }
  it { should_not have_valid(:user_id).when('test') }
  it { should validate_presence_of(:user_id) }
  it { should validate_numericality_of(:user_id) }

  it { should have_valid(:friend_id).when(1) }
  it { should_not have_valid(:friend_id).when('test') }
  it { should validate_presence_of(:friend_id) }
  it { should validate_numericality_of(:friend_id) }
end
