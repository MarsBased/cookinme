# == Schema Information
#
# Table name: recipe_photos
#
#  id         :integer          not null, primary key
#  photo      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  recipe_id  :integer
#

class RecipePhoto < ActiveRecord::Base

  belongs_to :recipe, inverse_of: :recipe_photos

  validates :recipe_id, presence: true
  validates :photo, presence: true
  validates :photo, :file_size => { :maximum => 10.megabytes }

  mount_uploader :photo, RecipePhotoUploader

end
