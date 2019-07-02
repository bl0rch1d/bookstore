ActiveAdmin.register Book do
  permit_params :title, :description, :height, :width, :depth, :materials, :price, :quantity, :category_id, :author_id, :book_images

  index do
    selectable_column

    column 'Book cover' do |book|
      image_tag book.book_images.first.image.small.url
    end

    column :category

    column 'Title' do |resource|
      link_to resource.title.to_s, resource_path(resource)
    end

    column :authors do |book|
      book.authors(&:to_s)
    end

    column 'Short description' do |book|
      book.description.slice(1..63) + '...'
    end

    column 'Price' do |book|
      "€#{book.price}"
    end

    actions
  end

  show do
    h1 book.title

    panel 'Book Images' do
      table do
        book.book_images.each do |book_image|
          span image_tag book_image.image.medium.url
        end
      end
    end

    attributes_table do
      row :authors
      row :category
      row :year
      row :description

      row :materials

      row :height
      row :width
      row :depth

      row :price

      row :created_at
      row :updated_at
    end

    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :category, as: :radio
      f.input :authors, as: :check_boxes
      f.input :description
      f.input :year
      f.input :price
      f.input :materials, as: :check_boxes
      f.input :height
      f.input :width
      f.input :depth
      f.input :quantity
    end

    f.has_many :book_images, heading: false, allow_destroy: true do |image|
      image.input :book_image, as: :file, hint: image_tag(image.object.image.medium.url.to_s)
    end

    f.actions
  end
end
