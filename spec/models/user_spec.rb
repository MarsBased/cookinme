# == Schema Information
#
# Table name: users
#
#  id                              :integer          not null, primary key
#  username                        :string(255)      not null
#  email                           :string(255)
#  crypted_password                :string(255)
#  salt                            :string(255)
#  created_at                      :datetime
#  updated_at                      :datetime
#  remember_me_token               :string(255)
#  remember_me_token_expires_at    :datetime
#  reset_password_token            :string(255)
#  reset_password_token_expires_at :datetime
#  reset_password_email_sent_at    :datetime
#  avatar                          :string(255)
#

require 'spec_helper'

describe User do

  before :each do
   create(:user)
  end

  it { should have_many(:authentications).dependent(:destroy) }
  it { should have_many(:recipes).dependent(:destroy) }
  it { should have_many(:cookbooks).dependent(:destroy) }

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:password).on(:create) }
  it { should ensure_length_of(:password).is_at_least(6) }
  it { should accept_nested_attributes_for(:authentications) }

  describe "validates_presence_of_password_confirmation if updates_password" do
    it "is not valid when no password supplied" do
      expect(build(:user, updates_password: true)).to_not be_valid
    end
    it "is valid when password confirmation matches current password" do
      user = build(:user, updates_password: true,
        password: "a"*8, password_confirmation: "a"*8)
      expect(user).to be_valid
    end
  end

  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "has a valid with_avatar factory" do
    expect(build(:user_with_avatar)).to be_valid
  end

  describe "#has_avatar" do
    it "returns true if has an avatar" do
      expect(build(:user).has_avatar).to be_false
    end

    it "returns true if doesn't have an avatar" do
      expect(build(:user_with_avatar).has_avatar).to be_true
    end
  end

end
