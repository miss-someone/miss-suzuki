class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string  :name,  null: false
      t.string  :image
      t.string  :image_tmp
      t.boolean :is_active, null: false
      t.text    :memo, null: true

      t.timestamps null: false
    end
  end
end
