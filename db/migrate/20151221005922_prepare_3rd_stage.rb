class Prepare3rdStage < ActiveRecord::Migration
  def change
    add_column :contestant_profiles, :is_in_semifinal, :boolean, default: false, null: false
    add_column :contestant_profiles, :semifinal_votes, :integer, default: 0
    add_column :contestant_profiles, :movie_url, :string, null: true
  end
end
