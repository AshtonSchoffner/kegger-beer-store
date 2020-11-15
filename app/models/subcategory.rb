class Subcategory < ApplicationRecord
  belongs_to :category
  has_many :beer
end
