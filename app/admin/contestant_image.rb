ActiveAdmin.register ContestantImage do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end
  permit_params :user_id, :profile_image, :profile_image_crop_param_x,
                :profile_image_crop_param_y, :profile_image_crop_param_height,
                :profile_image_crop_param_width, :is_pending

  index do
    selectable_column
    id_column
    column :user_id
    column '画像' do |img|
      image_tag img.profile_image.thumb_at_mypage, width: 100
    end
    column :is_pending
  end

  show do
    attributes_table do
      row :user
      row :profile_image do
        image_tag contestant_image.profile_image.thumb_at_mypage, width: 300
      end
      row :is_pending
    end
  end

  form do |f|
    f.inputs 'ContestantImage' do
      f.input :user_id
      f.input :profile_image
      f.input :profile_image_crop_param_x
      f.input :profile_image_crop_param_y
      f.input :profile_image_crop_param_height
      f.input :profile_image_crop_param_width
      f.input :is_pending

      action :submit
    end
  end

  batch_action :approve do |ids|
    ContestantImage.find(ids).each { |image| image.update(is_pending: false) }
    redirect_to collection_path, alert: "承認しました"
  end
end
