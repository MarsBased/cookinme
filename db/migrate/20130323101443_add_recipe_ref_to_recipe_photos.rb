class AddRecipeRefToRecipePhotos < ActiveRecord::Migration
  def change
    add_reference :recipe_photos, :recipe, index: true
  end
end
