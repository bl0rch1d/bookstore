CATEGORIES = ['Mobile development', 'Photo', 'Web design', 'Web development'].freeze
MATERIALS = ['glossy paper', 'hardcover', 'soft paper', 'cardboard'].freeze
LIMIT = 20
BOOK_DIMENSIONS_RANGE = (1.0..10.0).freeze

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

CATEGORIES.each do |category|
  Category.create!(title: category)
end

MATERIALS.each do |material|
  Material.create!(title: material)
end

LIMIT.times do
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
    review.body         = FFaker::HipsterIpsum.words(rand(5..30)).join(' ')
    review.rating       = rand(1..5)
    review.state        = :unprocessed
    review.customer_id  = Customer.all.sample.id
    review.book_id      = Book.all.sample.id
  end
end

Book.all.each do |book|
  image = File.open(Rails.root.join("app/assets/images/#{rand(1..9)}.jpg"))

  4.times do
    BookImage.create! do |book_image|
      book_image.image    = image
      book_image.book_id  = book.id
    end
  end
end
