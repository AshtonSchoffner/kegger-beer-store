class OrderItem < ApplicationRecord
  belongs_to :beer
  belongs_to :order
end
