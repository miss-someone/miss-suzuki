ActiveAdmin.register ContestantProfile do
  actions :index, :show

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

  controller do
    def scoped_collection
      super.includes :user
    end
  end
end
