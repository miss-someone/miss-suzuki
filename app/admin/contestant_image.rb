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

  show do
    attributes_table do
      row :user
      row :profile_image do
        image_tag contestant_image.profile_image.thumb_at_mypage, width: 300
      end
      row :is_pending
    end
  end

  permit_params :user, :profile_image, :is_pending

end
