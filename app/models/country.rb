class Country < ApplicationRecord
  has_many :brewer

  validates :name, presence: true, uniqueness: true
end
