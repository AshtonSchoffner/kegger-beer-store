class RemoveReferencesFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :references, :provinces
  end
end
