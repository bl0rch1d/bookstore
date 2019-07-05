ActiveAdmin.register Book do
  permit_params :title, :description, :height, :width, :depth,
                :materials, :price, :quantity, :category_id, :author_id, :images

  decorate_with BookDecorator

  index do
    selectable_column

    column 'Book cover' do |book|
      image_tag book.thumb
    end

    column :category

    column :title do |resource|
      link_to resource.title.to_s, resource_path(resource)
    end

    column :authors, &:format_authors

    column 'Short description', &:short_description

    column :price, &:price_in_currency

    actions
  end

  show do
    h1 book.title

    panel 'Book Images' do
      table do
        # Because of activstorage does not allow upload identical images
        4.times { span image_tag book.images.first.variant(resize: '200x200') }
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

    # === With carrierwave ===
    # f.has_many :images, heading: false, allow_destroy: true do |book_image|
    #   book_image.input :image, as: :file, hint: image_tag(book_image.object.image.medium.url.to_s)
    # end

    # f.has_many book.images do |t|
    # end

    # f.inputs do
    #   f.input :images, as: :file, input_html: { multiple: true }
    # end

    
    # binding.pry
    

    # f.has_many :attachments, allow_destroy: true do |book_image|
    #   book_image.input :image, as: :file
    # end

    # f.inputs do
    #   f.input :image, as: :file
    # end

    f.actions
  end
end
