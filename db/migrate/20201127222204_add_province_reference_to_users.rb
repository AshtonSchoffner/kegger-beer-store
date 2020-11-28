class AddProvinceReferenceToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :references, :provinces
  end
end
