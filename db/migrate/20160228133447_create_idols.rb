class CreateIdols < ActiveRecord::Migration
  def change
    create_table :idols do |t|

      t.timestamps null: false
    end
  end
end
