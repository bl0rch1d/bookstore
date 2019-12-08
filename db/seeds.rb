AdminUser.destroy_all
Category.destroy_all
Material.destroy_all
Author.destroy_all
ShippingMethod.destroy_all
Coupon.destroy_all

FactoryBot.create(:admin_user)
FactoryBot.create_list(:category, 4)
FactoryBot.create_list(:shipping_method, 3)
FactoryBot.create_list(:coupon, 5)
FactoryBot.create_list(:author, 25)

Category.all.each do |category|
  FactoryBot.create_list(:book, rand(5..15), :with_random_images_count, category: category)
end
