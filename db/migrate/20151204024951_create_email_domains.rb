class CreateEmailDomains < ActiveRecord::Migration
  def change
    create_table :email_domains do |t|
      t.string  :domain, null: false
      t.boolean :is_forbidden, default: false
      t.boolean :is_notified, default: false
      t.timestamps null: false
    end

    add_index :email_domains, :domain, unique: true
  end
end
