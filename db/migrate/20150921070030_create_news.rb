class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.date    :date,          null:     false
      t.boolean :is_important,  default:  false
      t.text    :content,       null:     false

      t.timestamps null: false
    end
  end
end
