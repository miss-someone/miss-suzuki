class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string  :name,  null: false
      t.string  :image, null: false
      t.boolean :is_active, null: false
      t.text    :memo, null: true

      t.timestamps null: false
    end
  end
end
