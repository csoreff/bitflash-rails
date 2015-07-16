require 'rails_helper'

describe User do
  it { should have_many :friendships }
  it { should have_many :btcaddresses }
  it { should have_many :friends }
end
