class CreatePlants < ActiveRecord::Migration[7.0]
  def change
    create_table :plants do |t|
      t.string :name
      t.string :category
      t.string :image
      t.string :description
      t.float :price
      t.integer :quantity

      t.timestamps
    end
  end
end
