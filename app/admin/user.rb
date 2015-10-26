ActiveAdmin.register User do
  actions :index, :show, :edit, :update

  permit_params :email

  index do
    selectable_column
    id_column
    column :email
  end

  show do
    attributes_table do
      row :id
      row :email
      row '名前' do
        user.profile.name
      end
      row :user_type
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs 'UserInfo' do
      li user.profile.name
      f.input :email

      actions :submit
    end
  end
end
