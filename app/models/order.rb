class Order < ApplicationRecord
  belongs_to :province
  belongs_to :user
  has_many :order_items
end
