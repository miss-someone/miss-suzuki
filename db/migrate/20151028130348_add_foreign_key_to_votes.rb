class AddForeignKeyToVotes < ActiveRecord::Migration
  def change
    add_foreign_key :votes, :users, column: :voter_id, on_delete: :cascade, on_update: :cascade
    add_foreign_key :votes, :users, column: :contestant_id, on_delete: :cascade, on_update: :cascade
  end
end
