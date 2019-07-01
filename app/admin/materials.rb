ActiveAdmin.register Material do
  permit_params :name

  index do
    selectable_column

    column "Title" do |resource|
      link_to resource.title, resource_path(resource)
    end
  end
end
