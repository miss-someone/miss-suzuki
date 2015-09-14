class AddCropParamToContestantProfiles < ActiveRecord::Migration
  def change
    add_column :contestant_profiles, :profile_image_crop_param_x, :integer
    add_column :contestant_profiles, :profile_image_crop_param_y, :integer
    add_column :contestant_profiles, :profile_image_crop_param_width, :integer
    add_column :contestant_profiles, :profile_image_crop_param_height, :integer
  end
end
