ActiveAdmin.register Coupon do
  permit_params :code, :discount, :expire_date

  decorate_with CouponDecorator

  index do
    selectable_column

    column :code

    column :discount, &:format_discount

    column :expire_date

    actions
  end
end
