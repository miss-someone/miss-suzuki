class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.integer   :user_id,     null: false
      t.string    :nickname,    null: false
      t.integer   :sex,         null: false
      t.string    :age,         null: false
      t.string    :prefecture,  null: false

      t.timestamps null: false
    end

    add_index :user_profiles, :user_id, unique: true
  end
end
