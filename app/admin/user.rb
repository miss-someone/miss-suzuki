ActiveAdmin.register User do
  actions :index, :show, :edit, :update

  permit_params :email, :activation_state

  index do
    selectable_column
    id_column
    column :email
    column :activation_state
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

  batch_action :activate do |ids|
    begin
      fail 'ミスオペを防ぐため，20件以上は一括更新できません' if ids.size >= 20

      User.transaction do
        User.find(ids).each { |user| user.update_attribute(:activation_state, 'active') }
      end
      redirect_to collection_path, alert: "アクティベートしました"
    rescue => e
      redirect_to collection_path, alert: "アクティベート失敗[ #{e.message} ]"
    end
  end

  batch_action :inactivate do |ids|
    begin
      fail 'ミスオペを防ぐため，20件以上は一括更新できません' if ids.size >= 20

      User.transaction do
        User.find(ids).each { |user| user.update_attribute(:activation_state, 'pending') }
      end
      redirect_to collection_path, alert: "インアクティベートしました"
    rescue => e
      redirect_to collection_path, alert: "インアクティベート失敗[ #{e.message} ]"
    end
  end
end
