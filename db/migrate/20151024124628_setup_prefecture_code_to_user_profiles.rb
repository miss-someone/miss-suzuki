class SetupPrefectureCodeToUserProfiles < ActiveRecord::Migration
  def change
    remove_column :user_profiles, :prefecture
    add_column :user_profiles, :prefecture_code, :integer
  end
end
