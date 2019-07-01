class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text :body
      t.integer :rating
      t.string :state
      t.references :customer, foreign_key: true
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
