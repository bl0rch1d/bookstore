class RemoveExpireDateFromCoupon < ActiveRecord::Migration[5.2]
  def change
    remove_column :coupons, :expire_date, :string
  end
end
