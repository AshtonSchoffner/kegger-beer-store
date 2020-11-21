class Beer < ApplicationRecord
  has_one_attached :image

  belongs_to :brewer
  belongs_to :subcategory

  validates :name, presence: true
  validates :price, presence: true
  validates :subcategory, presence: true
end
