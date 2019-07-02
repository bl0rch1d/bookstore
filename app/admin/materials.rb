ActiveAdmin.register Material do
  permit_params :name

  index do
    selectable_column

    column :title

    actions
  end
end
