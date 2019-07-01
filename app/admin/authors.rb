ActiveAdmin.register Author do
  permit_params :first_name, :last_name

  index do
    selectable_column

    column 'Full name' do |author|
      author.to_s
    end

    actions
  end
end
