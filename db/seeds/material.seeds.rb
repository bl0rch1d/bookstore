MATERIALS = ['glossy paper', 'hardcover', 'soft paper', 'cardboard'].freeze

MATERIALS.each do |material|
  Material.create!(title: material)
end
