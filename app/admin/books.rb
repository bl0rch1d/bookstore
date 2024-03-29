ActiveAdmin.register Book do
  permit_params :title, :description, :height, :width, :depth,
                :material_ids, :year, :price, :quantity, :category_id, :author_ids, images: []

  decorate_with BookDecorator

  index do
    selectable_column

    column I18n.t('book.cover') do |book|
      image_tag book.thumb if book.images.any?
    end

    column :category

    column :title do |resource|
      link_to resource.title.to_s, resource_path(resource)
    end

    column :authors, &:format_authors

    column I18n.t('book.short_description'), &:short_description

    column :price do |book|
      number_to_currency(book.price, unit: I18n.t('currency.euro'))
    end

    actions
  end

  show do
    h1 book.title

    panel I18n.t('book.images') do
      table do
        book.images.each do |image|
          span image_tag image.variant(resize: I18n.t('resize.middle'))
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

      f.input :authors, as: :check_boxes, collection: AuthorDecorator.decorate_collection(Author.all)

      f.input :description
      f.input :year
      f.input :price
      f.input :materials, as: :check_boxes
      f.input :height
      f.input :width
      f.input :depth
      f.input :quantity
    end

    f.inputs do
      f.input :images, as: :file, input_html: { multiple: true }
    end

    f.object.images.each do |image|
      span image_tag image.variant(resize: I18n.t('resize.thumb'))
      span link_to(I18n.t('link_to.delete'), delete_book_image_admin_book_path(image.id),
                   method: :delete, data: { confirm: I18n.t('book.image_remove_confirmation') })
    end

    f.actions
  end

  member_action :delete_book_image, method: :delete do
    @image = ActiveStorage::Attachment.find(params[:id])
    @image.purge_later

    redirect_back(fallback_location: edit_admin_book_path)
  end
end
