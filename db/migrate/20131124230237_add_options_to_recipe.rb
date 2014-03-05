class AddOptionsToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :time, :string
    add_column :recipes, :guests, :string
    add_column :recipes, :difficulty, :string
  end
end
