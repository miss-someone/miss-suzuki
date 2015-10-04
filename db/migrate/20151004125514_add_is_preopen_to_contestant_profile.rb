class AddIsPreopenToContestantProfile < ActiveRecord::Migration
  def change
    add_column :contestant_profiles, :is_preopen, :boolean, null: false, default: false
  end
end
