class AddLinkTypeToContestantProfile < ActiveRecord::Migration
  def change
    add_column :contestant_profiles, :link_type, :integer
  end
end
