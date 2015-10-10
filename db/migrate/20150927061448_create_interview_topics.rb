class CreateInterviewTopics < ActiveRecord::Migration
  def change
    create_table :interview_topics do |t|
      t.string  :topic, null: false
      t.timestamps null: false
    end
    add_index :interview_answers, :interview_topic_id
    add_index :interview_answers, :user_id
  end
end
