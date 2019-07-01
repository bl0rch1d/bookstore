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
    
    panel "Book Images" do
      table do
        book.images.each do |image|
          span image_tag image
        end
      end
    end

    attributes_table do
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
      f.input :dimensions
      f.input :quantity
      f.input :images, as: :file, input_html: { multiple: true  }
    end

    f.actions
  end
end
