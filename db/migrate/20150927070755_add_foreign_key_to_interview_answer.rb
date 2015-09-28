class AddForeignKeyToInterviewAnswer < ActiveRecord::Migration
  def change
    add_foreign_key :interview_answers, :interview_topics, column: :interview_topic_id, on_delete: :cascade, on_update: :cascade
    add_foreign_key :interview_answers, :users, column: :user_id, on_delete: :cascade, on_update: :cascade
  end
end
