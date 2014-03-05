# == Schema Information
#
# Table name: recipes
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  cookbook_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#  time        :integer
#  guests      :integer
#  difficulty  :string(255)
#

class Recipe < ActiveRecord::Base

  belongs_to :cookbook, inverse_of: :recipes
  belongs_to :user, inverse_of: :recipes
  has_many :recipe_photos, :dependent => :destroy

	validates :title, length: { maximum: 200 }
	validates :description, length: { maximum: 2000 }
  validates :user_id, presence: true
  validates_inclusion_of :difficulty, in: %w(easy medium hard), allow_nil: true
  validates_inclusion_of :time, in: %w(15' 30' 45' 60' +90'), allow_nil: true
  validates_inclusion_of :guests, in: %w(2 4 6 +8), allow_nil: true

  scope :with_photo, ->{joins(:recipe_photos).uniq.order(created_at: :desc)}

  # Checks whether the recipe has any photo
  def has_any_photo
    recipe_photos.any?
  end

  # Retrieves (if any) the main photo for the recipe. For now,
  # the main photo comes from the first recipe with photo availiable.
  def main_photo
    recipe_photos.first.try(:photo)
  end

  # If the recipe hasn't got any photo, it is created.
  # Otherwise it is updated.
  def create_or_update_photo! file
    if recipe_photos.any?
      photo = recipe_photos.first
      photo.update!(photo: file)
      photo
    else
      recipe_photos.create(photo: file)
    end
  end

end
