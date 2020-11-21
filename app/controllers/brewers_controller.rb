class BrewersController < ApplicationController
  def index
    @brewers = Brewer.includes(:country).order("name ASC").page(params[:page]).per(30)
  end

  def show
    @brewer = Brewer.includes(:beer, :country).find(params[:id])
  end
end
