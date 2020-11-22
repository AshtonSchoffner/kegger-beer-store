class SubcategoriesController < ApplicationController
  def show
    @subcategory = Subcategory.includes(:beer, :category).find(params[:id])
    @beers = Beer.where(subcategory_id: @subcategory.id).order("name ASC").page(params[:page]).per(30)
  end
end
