class CreateShippingMethods < ActiveRecord::Migration[5.2]
  def change
    create_table :shipping_methods do |t|
      t.string :title
      t.integer :min_days
      t.integer :max_days
      t.decimal :price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
