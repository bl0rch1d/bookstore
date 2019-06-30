CATEGORIES = ['Mobile development', 'Photo', 'Web design', 'Web development']
MATERIALS = ['glossy paper', 'hardcover', 'soft paper', 'cardboard']
LIMIT = 20
BOOK_DIMENSIONS_RANGE = (1.0..10.0).freeze

CATEGORIES.each do |category|
  Category.create!(title: category)
end

MATERIALS.each do |material|
  Material.create!(name: material)
end

LIMIT.times do
  Author.create! do |author|
    author.first_name = FFaker::Name.first_name
    author.last_name = FFaker::Name.last_name
  end

  Book.create! do |book|
    book.title = FFaker::Book.title
    book.description = FFaker::Book.description
    book.price = rand(5.0..200.00)
    book.quantity = rand(1..10)
    book.dimensions = "h: #{rand(BOOK_DIMENSIONS_RANGE).round(1)} w: #{rand(BOOK_DIMENSIONS_RANGE).round(1)} d: #{rand(BOOK_DIMENSIONS_RANGE).round(1)}"
    book.year = rand(1850..2019)
    book.materials = Material.all.sample(rand(1..3))
    book.category_id = Category.all.sample.id
    book.authors = Author.all.sample(rand(1..3))
    book.image = File.open(Rails.root.join("app/assets/images/small/#{rand(1..4)}.jpg"))
  end
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?