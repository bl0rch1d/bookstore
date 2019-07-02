class CreateBookImages < ActiveRecord::Migration[5.2]
  def change
    create_table :book_images do |t|
      t.references :book, foreign_key: true
      t.string :image

      t.timestamps
    end
  end
end
