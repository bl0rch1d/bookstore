ActiveAdmin.register Author do
  permit_params :first_name, :last_name

  index do
    selectable_column

    column 'Full name', &:to_s

    actions
  end
end
