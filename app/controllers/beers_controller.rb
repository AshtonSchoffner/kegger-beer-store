class BeersController < ApplicationController
  def index
    @beers = Beer.includes(:subcategory, :brewer).order("name ASC").page(params[:page]).per(30)
  end

  def show
    @beer = Beer.find(params[:id])
  end
end
