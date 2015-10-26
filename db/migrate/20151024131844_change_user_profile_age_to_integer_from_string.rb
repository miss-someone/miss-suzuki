class ChangeUserProfileAgeToIntegerFromString < ActiveRecord::Migration
  def change
    remove_column :user_profiles, :age, :string
    add_column :user_profiles, :age_id, :integer, null: false
  end
end
