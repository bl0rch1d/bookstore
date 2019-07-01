ActiveAdmin.register Category do
  permit_params :title

  index do
    selectable_column

    column 'Title' do |resource|
      link_to resource.title, resource_path(resource)
    end

    actions
  end
end
