CATEGORIES = ['Mobile development', 'Photo', 'Web design', 'Web development'].freeze
MATERIALS = ['glossy paper', 'hardcover', 'soft paper', 'cardboard'].freeze
SEEDS_COUNT = 50
SHIPPING_METHODS_COUNT = 3
COUPONS_COUNT = 5
BOOK_DIMENSIONS_RANGE = (1.0..10.0).freeze

COUPON_DISCOUNT_RANGE    = (0.01..0.90).freeze

if Rails.env.development?
  AdminUser.create!(
    email: 'kojima_genius@example.com',
    password: 'KaminoAlive',
    password_confirmation: 'KaminoAlive'
  )
end

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
  end
end

COUPONS_COUNT.times do
  Coupon.create! do |coupon|
    coupon.code         = Array.new(6) { rand(65..90).chr }.join
    coupon.discount     = rand(COUPON_DISCOUNT_RANGE).round(2)
    coupon.used         = false
  end
end

Book.all.each do |book|
  rand(0..4).times do
    book.images.attach(
      io: File.open(Rails.root.join("app/assets/images/#{rand(1..9)}.jpg")),
      filename: "cover.jpg",
      content_type: "image/jpg"
    )
  end
end
