class CreateContestantProfiles < ActiveRecord::Migration
  def change
    create_table :contestant_profiles do |t|
      t.integer   :user_id,     null: false
      t.integer   :group_id,    null: false
      t.string    :name,        null: false
      t.string    :hurigana,    null: false
      t.string    :image_url,   null: false
      t.string    :age,         null: false
      t.string    :height,      null: false
      t.string    :come_from,   null: false
      t.string    :link_url,    null: false
      t.text      :comment,     null: false
      t.integer   :votes,       default: 0
      t.text      :thanks_comment, null: false
      t.string    :phone
      t.string    :station
      t.boolean   :is_interest_in_idol_group

      t.timestamps null: false
    end

    add_index :contestant_profiles, :user_id, unique: true
  end
end
