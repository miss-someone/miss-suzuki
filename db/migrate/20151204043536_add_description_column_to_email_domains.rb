class AddDescriptionColumnToEmailDomains < ActiveRecord::Migration
  def change
    add_column :email_domains, :description, :string, null: true
  end
end
