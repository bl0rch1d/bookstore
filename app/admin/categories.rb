ActiveAdmin.register Category do
  permit_params :title

  index do
    selectable_column

    column :title

    actions
  end
end
