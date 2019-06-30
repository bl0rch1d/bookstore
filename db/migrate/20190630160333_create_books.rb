class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.decimal :price, precision: 10, scale: 2
      t.integer :quantity
      t.string :dimensions
      t.integer :year
      t.string :materials
      t.string :image
      t.references :category, foreign_ley: true

      t.timestamps
    end
  end
end
