ActiveAdmin.register Coupon do
  permit_params :code, :discount, :used

  decorate_with CouponDecorator

  index do
    selectable_column

    column :code

    column :discount, &:format_discount

    column :used

    actions
  end
end
