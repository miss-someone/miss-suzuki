class SetupPrefectureCodeToUserProfiles < ActiveRecord::Migration
  def change
    remove_column :user_profiles, :prefecture, :string
    add_column :user_profiles, :prefecture_code, :integer, null: false
  end
end
