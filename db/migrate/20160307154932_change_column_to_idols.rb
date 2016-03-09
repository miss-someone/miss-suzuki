class ChangeColumnToIdols < ActiveRecord::Migration
  def change
    change_column_null :idols, :email, false, default: ""
  end
end
