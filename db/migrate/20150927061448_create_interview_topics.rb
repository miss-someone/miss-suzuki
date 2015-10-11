class CreateInterviewTopics < ActiveRecord::Migration
  def change
    create_table :interview_topics do |t|
      t.string  :topic, null: false
      t.timestamps null: false
    end
  end
end
