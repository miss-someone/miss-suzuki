ActiveAdmin.register InterviewAnswer do
  actions :index, :show, :edit, :update
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
    column :interview_topic do |interview_answer|
      interview_answer.interview_topic.topic
    end
    column '名前' do |answer|
      # FIXME: N+1 Query
      answer.user.profile.name
    end
    column :user
    column :answer
    column :is_pending
    actions
  end

  permit_params :interview_topic_id, :user_id, :answer, :is_pending

  batch_action :approve do |ids|
    # FIXME: トランザクション
    InterviewAnswer.find(ids).each { |answer| answer.update(is_pending: false) }
    redirect_to collection_path, alert: "承認しました"
  end

  batch_action :delete do |ids|
    # FIXME: トランザクション
    InterviewAnswer.find(ids).each(&:destroy)
    redirect_to collection_path, alert: "削除しました"
  end
end
