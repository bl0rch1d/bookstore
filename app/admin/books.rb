ActiveAdmin.register Book do
  permit_params :title, :description, :dimenstions, :materials, :price, :quantity, :category_id, :author_id, :images

  index do
    selectable_column

    column :image do |book|
      image_tag book.images.first
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

    attributes_table do
      row "Images" do |book|
        book.images do |image|
          image_tag image
        end
      end

      row :authors
      row :category
      row :year
      row :description

      row :materials
      row :dimensions

      row :price

      row :created_at
      row :updated_at
    end
  end

  form do |f|
    inputs

    f.inputs do
      f.input :images, as: :file, input_html: { multiple: true  }
    end
    
    f.actions
  end
end
