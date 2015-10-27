class CreateContestantImages < ActiveRecord::Migration
  def change
    create_table :contestant_images do |t|
      t.integer :user_id
      t.string  :profile_image,   null: false
      t.integer :profile_image_crop_param_x,  null: false
      t.integer :profile_image_crop_param_y,  null: false
      t.integer :profile_image_crop_param_width,  null: false
      t.integer :profile_image_crop_param_height,  null: false

      t.timestamps null: false
    end
  end
end
