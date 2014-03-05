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

class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  # Flag used to be able to check if password needs to be updated or not
  attr_accessor :updates_password

  has_many :authentications, :dependent => :destroy
  has_many :recipes, :dependent => :destroy
  has_many :cookbooks, :dependent => :destroy

  validates_presence_of :username, :email
  validates_uniqueness_of :email
  validates_presence_of :password_confirmation, if: 'updates_password'
  validates :password, presence: { :on => :create }
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :password, confirmation: true, if: 'updates_password'

  accepts_nested_attributes_for :authentications
  mount_uploader :avatar, AvatarUploader

  def has_avatar
    avatar.present?
  end

end
