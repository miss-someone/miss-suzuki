class AddCropExtraParamToContestantProfiles < ActiveRecord::Migration
  def change
    add_column :contestant_profiles, :profile_image_crop_param_extra, :string, null: false, default: ''
    add_column :contestant_profiles, :profile_image_blur_param, :integer, null: false, default: 0
  end
end
