CATEGORIES = ['Mobile development', 'Photo', 'Web design', 'Web development'].freeze
MATERIALS = ['glossy paper', 'hardcover', 'soft paper', 'cardboard'].freeze
SEEDS_COUNT = 50
SHIPPING_METHODS_COUNT = 3
BOOK_DIMENSIONS_RANGE = (1.0..10.0).freeze

COUPON_EXPIRE_DATE_RANGE = (1.0001..1.009).freeze
# COUPON_EXPIRE_DATE_RANGE = (0.9..1.009).freeze
COUPON_DISCOUNT_RANGE    = (0.01..0.90).freeze

AdminUser.create!(email: 'kojima_genius@example.com', password: 'KaminoAlive', password_confirmation: 'KaminoAlive') if Rails.env.development?

CATEGORIES.each do |category|
  Category.create!(title: category)
end

MATERIALS.each do |material|
  Material.create!(title: material)
end

SHIPPING_METHODS_COUNT.times do
  ShippingMethod.create! do |method|
    method.title    = FFaker::CheesyLingo.unique.title
    method.min_days = rand(1..5)
    method.max_days = rand(6..20)
    method.price    = rand(1.0..50.0).round(1)
  end
end

SEEDS_COUNT.times do |index|
  Author.create! do |author|
    author.first_name = FFaker::Name.unique.first_name
    author.last_name  = FFaker::Name.last_name
  end

  Book.create! do |book|
    book.title        = FFaker::Book.unique.title
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
    book.images.attach(io: File.open(Rails.root.join("app/assets/images/#{rand(1..9)}.jpg")), filename: "cover.jpg", content_type: "image/jpg")
  end

  # User.create! do |user|
  #   user.email    = FFaker::Internet.unique.email
  #   user.password = FFaker::Internet.password
  # end

  # Review.create! do |review|
  #   review.title        = FFaker::Book.title
  #   review.body         = FFaker::HipsterIpsum.words(rand(5..30)).join(' ')
  #   review.rating       = rand(1..5)
  #   review.user_id      = User.all.sample.id
  #   review.book_id      = Book.all.sample.id
  # end

  # ShippingMethod.create! do |method|
  #   method.title    = FFaker::CheesyLingo.unique.title
  #   method.min_days = rand(1..5)
  #   method.max_days = rand(6..20)
  #   method.price    = rand(1.0..50.0).round(1)
  # end

  # Order.create! do |order|
  #   order.number              = Array.new(8) { rand(1..9) }.join
  #   order.total_price         = rand(50.0..500.0).round(1)
  #   order.user_id             = User.all[index].id
  #   order.shipping_method_id  = ShippingMethod.all[index].id
  #   order.state               = ['in_progress', 'delivered'].sample
  # end

  # OrderItem.create! do |order_item|
  #   order_item.price      = rand(10.0..200.0).round(1)
  #   order_item.quantity   = rand(1..10)
  #   order_item.subtotal   = order_item.price * order_item.quantity.to_f
  #   order_item.order_id   = Order.all[index].id
  #   order_item.book_id    = Book.all[index].id
  # end

  Coupon.create! do |coupon|
    coupon.code         = Array.new(6) { rand(65..90).chr }.join
    coupon.discount     = rand(COUPON_DISCOUNT_RANGE).round(2)
    coupon.expire_date  = Time.at(Time.now.to_i * rand(COUPON_EXPIRE_DATE_RANGE))
  end
end
