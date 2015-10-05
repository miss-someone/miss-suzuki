class AddStatusToContestantProfile < ActiveRecord::Migration
  def change
    add_column :contestant_profiles, :status, :integer, null: false, default: 0
  end
end
