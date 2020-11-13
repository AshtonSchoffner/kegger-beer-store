class Category < ApplicationRecord
  has_many :subcategory
  has_many :beer
end
