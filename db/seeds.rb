CATEGORIES = ['Mobile development', 'Photo', 'Web design', 'Web development'].freeze
MATERIALS = ['glossy paper', 'hardcover', 'soft paper', 'cardboard'].freeze
LIMIT = 100
BOOK_DIMENSIONS_RANGE = (1.0..10.0).freeze

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

CATEGORIES.each do |category|
  Category.create!(title: category)
end

MATERIALS.each do |material|
  Material.create!(title: material)
end

LIMIT.times do |index|
  puts 'Seeding Authors/Books/Customers/Reviews/Addresses/ShippingMethods
  '
  Author.create! do |author|
    author.first_name = FFaker::Name.first_name
    author.last_name  = FFaker::Name.last_name
  end

  Book.create! do |book|
    book.title        = FFaker::Book.title
    book.description  = FFaker::Book.description
    book.price        = rand(5.0..200.00)
    book.quantity     = rand(1..10)
    book.height       = rand(1.0..10.0).round(1)
    book.width        = rand(1.0..10.0).round(1)
    book.depth        = rand(1.0..10.0).round(1)
    book.year         = rand(1850..2019)
    book.materials    = Material.all.sample(rand(1..3))
    book.category_id  = Category.all.sample.id
    book.authors      = Author.all.sample(rand(1..3))
  end

  Customer.create! do |customer|
    customer.email    = FFaker::Internet.email
    customer.password = FFaker::Internet.password
  end

  Review.create! do |review|
    review.title        = FFaker::Book.title
    review.body         = FFaker::HipsterIpsum.words(rand(5..30)).join(' ')
    review.rating       = rand(1..5)
    review.customer_id  = Customer.all.sample.id
    review.book_id      = Book.all.sample.id
  end

  BillingAddress.create! do |address|
    address.first_name        = FFaker::Name.first_name
    address.last_name         = FFaker::Name.last_name
    address.address           = FFaker::AddressUS.street_address
    address.city              = FFaker::AddressUS.city
    address.zip               = FFaker::AddressUS.zip_code
    address.country           = FFaker::AddressUS.country
    address.phone             = FFaker::PhoneNumberNL.international_mobile_phone_number.gsub!(/\s+/, '')
    address.addressable_type  = 'Customer'
    address.addressable_id    = Customer.all[index].id
  end

  ShippingAddress.create! do |address|
    address.first_name        = FFaker::Name.first_name
    address.last_name         = FFaker::Name.last_name
    address.address           = FFaker::AddressUS.street_address
    address.city              = FFaker::AddressUS.city
    address.zip               = FFaker::AddressUS.zip_code
    address.country           = FFaker::AddressUS.country
    address.phone             = FFaker::PhoneNumberNL.international_mobile_phone_number.gsub!(/\s+/, '')
    address.addressable_type  = 'Customer'
    address.addressable_id    = Customer.all[index].id
  end

  ShippingMethod.create! do |method|
    method.title    = FFaker::CheesyLingo.title
    method.min_days = rand(1..5)
    method.max_days = rand(6..20)
    method.price    = rand(1.0..50.0).round(1)
  end

  Order.create! do |order|
    order.number              = Array.new(8) { rand(1..9) }.join
    order.total_price         = rand(50.0..500.0).round(1)
    order.customer_id         = Customer.all[index].id
    order.shipping_method_id  = ShippingMethod.all[index].id
  end

  OrderItem.create! do |order_item|
    order_item.price      = rand(10.0..200.0).round(1)
    order_item.quantity   = rand(1..10)
    order_item.order_id   = Order.all[index].id
    order_item.book_id    = Book.all[index].id
  end

  Coupon.create! do |coupon|
    coupon.code         = Array.new(6) { rand(65..90).chr }.join
    coupon.discount     = rand(5..90)
    coupon.expire_date  = Time.at(rand * Time.now.to_i)
  end
end

Book.all.each do |book|
  puts 'Book Images'

  book.images.attach(io: File.open(Rails.root.join("app/assets/images/#{rand(1..9)}.jpg")), filename: "cover.jpg", content_type: "image/jpg")
  
  # 4.times do |index|
  #   BookImage.create! do |book_image|
  #     book_image.image    = image
  #     book_image.book_id  = book.id
  #   end
  # end
end
