class AddProfileImageTmpToContestantImages < ActiveRecord::Migration
  def change
    add_column :contestant_images, :profile_image_tmp, :string
    # carrierwave_backgrounderによる，一時的なnullを許すため
    change_column :contestant_images, :profile_image, :string, null: true
  end
end
