SEEDS_COUNT = 50
BOOK_DIMENSIONS_RANGE = (1.0..10.0).freeze

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

Book.all.each do |book|
  rand(0..4).times do
    book.images.attach(
      io: File.open(Rails.root.join("app/assets/images/#{rand(1..9)}.jpg")),
      filename: "cover.jpg",
      content_type: "image/jpg"
    )
  end
end
