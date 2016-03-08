class AddColumsToIdols < ActiveRecord::Migration
  def change
    add_column :idols, :name, :string, null: false, default: ""
    add_column :idols, :email, :string, default: ""
    add_column :idols, :age, :string, null: false, default: ""
    add_column :idols, :school, :string
    add_column :idols, :height, :string, null: false, default: ""
    add_column :idols, :hometown, :string, null: false, default: ""
    add_column :idols, :station, :string, null: false, default: ""
    add_column :idols, :production, :boolean, null: false, default: false
    add_column :idols, :date, :string, null: false, default: ""
  end
end
