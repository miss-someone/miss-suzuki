class AddForeignKeyToUserProfile < ActiveRecord::Migration
  def change
    add_foreign_key :user_profiles, :users, column: :user_id, on_delete: :cascade, on_update: :cascade
  end
end
