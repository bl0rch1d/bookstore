ActiveAdmin.register Author do
  permit_params :first_name, :last_name

  decorate_with AuthorDecorator

  index do
    selectable_column

    column I18n.t('authors.full_name'), &:full_name

    actions
  end
end
