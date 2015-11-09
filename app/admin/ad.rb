ActiveAdmin.register Ad do
  actions :new, :create, :index, :show, :edit, :update

  permit_params :name, :image, :is_active, :memo

  index do
    selectable_column
    id_column
    column :name
    column '画像' do |ad|
      image_tag ad.image.url, width: 100
    end
    column :is_active
    column :memo
  end

  show do
    attributes_table do
      row :name
      row '画像' do |ad|
        image_tag ad.image.url, width: 100
      end
      row :is_active
      row :memo
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs 'AdInfo' do
      f.input :name
      f.input :image
      f.input :is_active
      f.input :memo
      actions
    end
  end
end
