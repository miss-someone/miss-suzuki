class CreateContestantTagContestants < ActiveRecord::Migration
  def change
    create_table :contestant_tag_contestants do |t|
      t.integer   :user_id,   null: false
      t.integer   :contestant_tag_id,    null: false

      t.timestamps null: false
    end

    add_index :contestant_tag_contestants, :user_id
    add_index :contestant_tag_contestants, :contestant_tag_id
  end
end
