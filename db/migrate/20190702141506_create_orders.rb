class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :number
      t.decimal :total_price, precision: 10, scale: 2
      t.datetime :completed_at
      t.string :state
      t.boolean :use_billing, default: false
      t.references :user, foreign_key: true
      t.references :shipping_method, foreign_key: true

      t.timestamps
    end
  end
end
