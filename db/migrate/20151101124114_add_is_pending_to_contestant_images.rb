class AddIsPendingToContestantImages < ActiveRecord::Migration
  def change
    add_column :contestant_images, :is_pending, :boolean, null: false, default: true
  end
end
