class Brewer < ApplicationRecord
  belongs_to :country
  has_many :beer
end
