class CreateRecipePhotos < ActiveRecord::Migration
  def change
    create_table :recipe_photos do |t|
      t.string :photo

      t.timestamps
    end
  end
end
