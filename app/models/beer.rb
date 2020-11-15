class Beer < ApplicationRecord
  belongs_to :brewer
  belongs_to :subcategory
end
