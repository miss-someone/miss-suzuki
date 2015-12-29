class AddSexToContestantProfiles < ActiveRecord::Migration
  def change
    add_column :contestant_profiles, :sex, :string, default: 'female', null: false
  end
end
