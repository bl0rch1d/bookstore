class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.string :code
      t.decimal :discount, precision: 10, scale: 2
      t.datetime :expire_date
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
