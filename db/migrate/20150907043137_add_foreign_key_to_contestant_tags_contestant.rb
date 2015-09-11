class AddForeignKeyToContestantTagsContestant < ActiveRecord::Migration
  def change
    add_foreign_key :contestant_tag_contestants, :users, column: :user_id, on_delete: :cascade, on_update: :cascade
    add_foreign_key :contestant_tag_contestants, :contestant_tags, column: :contestant_tag_id, on_delete: :cascade, on_update: :cascade
  end
end
