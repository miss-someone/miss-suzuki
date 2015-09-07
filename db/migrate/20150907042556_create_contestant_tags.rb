class CreateContestantTags < ActiveRecord::Migration
  def change
    create_table :contestant_tags do |t|
      t.string    :name, :null => false

      t.timestamps null: false
    end
  end
end
