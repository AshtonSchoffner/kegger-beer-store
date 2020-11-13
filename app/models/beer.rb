class Beer < ApplicationRecord
  belongs_to :category
  belongs_to :brewer
end
