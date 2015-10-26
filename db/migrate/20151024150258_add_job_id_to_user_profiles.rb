class AddJobIdToUserProfiles < ActiveRecord::Migration
  def change
    add_column :user_profiles, :job_id, :integer, null: false
  end
end
