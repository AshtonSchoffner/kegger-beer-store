class CartController < ApplicationController
  def create
    id = params[:id].to_i
    unless session[:cart].include?(id)
      session[:cart] << id
      beer = Beer.find(id)
      flash[:notice] = "#{beer.name} added to cart."
    end
    redirect_to root_path
  end

  def destroy
    id = params[:id].to_i
    session[:cart].delete(id)
    beer = Beer.find(id)
    flash[:notice] = "#{beer.name} removed from cart."
    redirect_to root_path
  end
end
