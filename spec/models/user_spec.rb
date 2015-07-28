require 'rails_helper'

describe User do
  it { should have_many :friendships }
  it { should have_many :btcaddresses }
  it { should have_many :transactions }
  it { should have_many(:friends).through(:friendships) }

  let(:user) { FactoryGirl.create(:user) }

  describe '#name' do
    it "returns a contact's full name as a string" do
      expect(user.name).to eq("Bit Flash")
    end
  end

  describe '#authenticate_user' do
    it "successfully authenticates a user with Gem API" do
      expect{user.authenticate_user}.to_not raise_error
    end
  end

  describe '#create_new_address' do
    it "successfully creates a new Bitcoin address" do
      expect{user.create_new_address}.to_not raise_error
    end
  end

  describe '#get_transactions' do
    it "successfully retrieves user's transactions from db" do
      expect(user.get_transactions).to_not eq(nil)
    end
  end
end
