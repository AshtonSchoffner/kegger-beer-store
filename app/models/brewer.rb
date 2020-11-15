class Brewer < ApplicationRecord
  belongs_to :country
  has_many :beer

  validates :name, presence: true
end
