class BeersController < ApplicationController
  def index
    @beers = Beer.includes(:subcategory, :brewer).order("name ASC").page(params[:page]).per(30)
  end

  def show
    @beer = Beer.find(params[:id])
  end

  def search
    wildcard_search = "%#{params[:keywords]}%"
    @beers = Beer.where("name LIKE ?", wildcard_search).order("name ASC")
  end
end
