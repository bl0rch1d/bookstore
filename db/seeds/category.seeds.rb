CATEGORIES = ['Mobile development', 'Photo', 'Web design', 'Web development'].freeze

CATEGORIES.each do |category|
  Category.create!(title: category)
end
