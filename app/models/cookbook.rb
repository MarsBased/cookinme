# == Schema Information
#
# Table name: cookbooks
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class Cookbook < ActiveRecord::Base

  has_many :recipes
  belongs_to :user, inverse_of: :cookbooks

  validates :title, length: { maximum: 200 }
  validates :user_id, presence: true

  def cover_image
    "cookbook.png"
  end

  def recipes_with_photo
    recipes.with_photo
  end

end
