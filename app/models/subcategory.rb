class Subcategory < ApplicationRecord
  belongs_to :category
  has_many :beer

  validates :name, presence: true
  validates :category, presence: true
end
