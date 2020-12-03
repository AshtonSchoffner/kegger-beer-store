class RenameColumnQunantityToQuantityOrderItems < ActiveRecord::Migration[6.0]
  def change
    rename_column :order_items, :qunatity, :quantity
  end
end
