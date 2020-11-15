class Beer < ApplicationRecord
  belongs_to :brewer
  belongs_to :subcategory

  validates :name, presence: true
  validates :price, presence: true
  validates :subcategory, presence: true
end
