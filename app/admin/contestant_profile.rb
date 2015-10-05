ActiveAdmin.register ContestantProfile do
  actions :index, :show, :edit, :update

  permit_params :name, :hurigana, :group_id, :profile_image, :age, :height,
                :come_from, :link_url, :comment, :thanks_comment, :station,
                :profile_image_crop_param_x, :profile_image_crop_param_y,
                :profile_image_crop_param_height, :profile_image_crop_param_width,
                :profile_image_crop_param_extra, :profile_image_blur_param

  index do
    selectable_column
    id_column
    column :user_id
    column :group_id
    column :name
    column :hurigana
    column 'メールアドレス' do |contestant_profile|
      contestant_profile.user.email
    end
    column :age
    column :height
    column :come_from
    column :phone
    column :station
    column :is_interest_in_idol_group
    column :is_share_with_twitter_ok
  end

  show do
    attributes_table do
      row :id
      row :user_id do
        link_to contestant_profile.user.id, admin_user_path(contestant_profile.user)
      end
      row :group_id
      row :name
      row :hurigana
      row "メールアドレス" do
        contestant_profile.user.email
      end
      row :profile_image do
        image_tag contestant_profile.profile_image.thumb, width: 300
      end
      row :age
      row :height
      row :link_url do
        link_to contestant_profile.link_url, contestant_profile.link_url
      end
      row 'タグ' do
        tags = ""
        contestant_profile.user.contestant_tags.each do |tag|
          tags += tag.name + ","
        end
        tags
      end
      row :phone
      row :come_from
      row :comment
      row :thanks_comment
      row :votes
      row :how_know
      row :station
      row :is_share_with_twitter_ok do
        contestant_profile.is_share_with_twitter_ok ? 'はい' : 'いいえ'
      end
      row :is_interest_in_idol_group do
        contestant_profile.is_interest_in_idol_group ? 'はい' : 'いいえ'
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs 'UserInfo' do
      f.input :name
      f.input :hurigana
      f.input :group_id
      f.input :profile_image
      li image_tag contestant_profile.profile_image.thumb(300,300)
      f.input :profile_image_crop_param_x
      f.input :profile_image_crop_param_y
      f.input :profile_image_crop_param_height
      f.input :profile_image_crop_param_width
      f.input :profile_image_crop_param_extra
      f.input :profile_image_blur_param
      f.input :age
      f.input :height
      f.input :come_from
      f.input :link_url
      f.input :comment
      f.input :thanks_comment
      f.input :station

      action :submit
    end
  end

  controller do
    def scoped_collection
      super.includes :user
    end
  end
end
