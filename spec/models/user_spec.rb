require 'rails_helper'

describe User do
  it { should have_many :friendships }
  it { should have_many :btcaddresses }
  it { should have_many :transactions }
  it { should have_many(:friends).through(:friendships) }
end
