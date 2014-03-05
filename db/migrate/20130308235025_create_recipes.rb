class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :description
      t.integer :cookbook_id

      t.timestamps
    end
    add_index :recipes, :cookbook_id
  end
end
