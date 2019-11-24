class CreateBooksMaterials < ActiveRecord::Migration[5.2]
  def change
    create_table :books_materials do |t|
      t.references :book, foreign_key: true
      t.references :material, foreign_key: true

      t.timestamps
    end
  end
end
