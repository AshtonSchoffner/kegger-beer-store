class RenameCustomersToUsers < ActiveRecord::Migration[6.0]
  def change
    rename_table :customers, :users
  end
end
