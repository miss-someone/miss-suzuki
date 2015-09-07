class AddForeignKeyToContestantProfiles < ActiveRecord::Migration
  def change
    add_foreign_key :contestant_profiles, :users, column: :user_id, on_delete: :cascade, on_update: :cascade
  end
end
