ActiveAdmin.register InterviewAnswer do
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
    id_column
    column :interview_topic_id
    column :user_id
    column :answer
    column :is_pending
  end

  permit_params :interview_topic_id, :user_id, :answer, :is_pending
end
