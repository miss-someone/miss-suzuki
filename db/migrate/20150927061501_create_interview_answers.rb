class CreateInterviewAnswers < ActiveRecord::Migration
  def change
    create_table :interview_answers do |t|
      t.integer :interview_topic_id,  null: false
      t.integer :user_id, null: false
      t.string  :answer,  null: false
      t.boolean :is_pending,  null: false

      t.timestamps null: false
    end
  end
end
