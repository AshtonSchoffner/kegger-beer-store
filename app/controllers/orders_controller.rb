class OrdersController < ApplicationController
  def index
    @orders = Order.where(user_id: current_user.id)
    @order_items = OrderItem.includes(:beer).where(order_id: @orders.ids)
  end
end
