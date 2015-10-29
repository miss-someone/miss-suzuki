class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :voter_id,      null: true
      t.integer :contestant_id, null: false
      t.integer :group_id,      null: false
      t.string  :ip_address,    null: true
      t.string  :cookie_token,  null: true
      t.timestamps null: false
    end

    add_index :votes, :voter_id
    add_index :votes, :contestant_id
    add_index :votes, :ip_address
    add_index :votes, :cookie_token
  end
end
