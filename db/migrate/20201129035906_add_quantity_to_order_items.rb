class AddQuantityToOrderItems < ActiveRecord::Migration[6.0]
  def change
    add_column :order_items, :qunatity, :integer
  end
end
