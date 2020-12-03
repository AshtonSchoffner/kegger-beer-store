class CategoriesController < ApplicationController
  def index
    @categories = Category.includes(:subcategories).order("name ASC")
    @subcategories = Subcategory.all.order("name ASC")
  end

  def show
    @category = Category.includes(:subcategories).find(params[:id])
    @beers = Beer.includes(:subcategory)
                 .where(subcategory_id: @category.subcategories.ids)
                 .order("name ASC")
                 .page(params[:page]).per(30)
  end
end
