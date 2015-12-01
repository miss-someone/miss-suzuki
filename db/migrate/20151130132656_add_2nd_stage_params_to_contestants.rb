class Add2ndStageParamsToContestants < ActiveRecord::Migration
  def change
    add_column :contestant_profiles, :is_in_2nd_stage, :boolean, default: false
    add_column :contestant_profiles, :second_stage_votes, :integer, default: 0
  end
end
