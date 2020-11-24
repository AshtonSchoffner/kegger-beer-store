class BeersController < ApplicationController
  def index
    @beers = Beer.includes(:subcategory, :brewer).order("name ASC").page(params[:page]).per(30)
  end

  def show
    @beer = Beer.find(params[:id])
  end

  def search
    wildcard_search = "%#{params[:keywords]}%"
    if params[:category_id] != "0"
      @category = Category.find(params[:category_id])
      @subcategories = Subcategory.where("category_id = ?", params[:category_id])
      @beers = Beer.includes(:subcategory)
                   .where("name LIKE ? AND subcategory_id IN (?)", wildcard_search, @subcategories.ids)
                   .order("name ASC")
                   .page(params[:page]).per(30)
    else
      @category = "All Categories"
      @beers = Beer.includes(:subcategory).where("name LIKE ?", wildcard_search).order("name ASC")
    end
  end
end
