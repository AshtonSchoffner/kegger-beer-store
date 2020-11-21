ActiveAdmin.register Beer do
  permit_params :name, :price, :alcohol_vol, :size, :quantity, :description, :brewer_id, :subcategory_id, :image

  form do |f|
    f.semantic_errors
    f.inputs
    f.inputs do
      f.input :image, as: :file
    end
    f.actions
  end
end
