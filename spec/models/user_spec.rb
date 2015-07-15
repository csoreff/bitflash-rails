require 'rails_helper'

describe User do
  it { should have_many :friendships }
  it { should have_many :addresses }
  it { should have_many :friends }
end
