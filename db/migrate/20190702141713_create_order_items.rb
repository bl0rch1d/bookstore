class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.decimal :price, precision: 10, scale: 2
      t.integer :quantity
      t.references :order, foreign_key: true
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
