class AddUsedToCoupon < ActiveRecord::Migration[5.2]
  def change
    add_column :coupons, :used, :boolean, default: false, null: false
  end
end
