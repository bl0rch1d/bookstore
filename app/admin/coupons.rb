ActiveAdmin.register Coupon do
  permit_params :code, :discount, :expire_date

  index do
    selectable_column

    column :code

    column :discount, &:format_discount

    column :expire_date

    actions
  end
end
