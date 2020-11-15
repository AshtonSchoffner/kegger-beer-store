ActiveAdmin.register Beer do
  permit_params :name, :price, :alcohol_vol, :size, :quantity, :description, :brewer_id, :subcategory_id
end
