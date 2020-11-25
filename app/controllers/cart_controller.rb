class CartController < ApplicationController
  def create
    id = params[:id]
    beers = session[:cart]

    if beers.keys.include?(id)
      session[:cart][id] += 1
    else
      session[:cart][id] = 1
    end

    beer = Beer.find(id)
    flash[:notice] = "#{beer.name} added to cart."

    if root_path = request.env["PATH_INFO"]
      redirect_to root_path
    else
      redirect_to cart_index_url
    end
  end

  def destroy
    id = params[:id]
    session[:cart].delete(id)
    beer = Beer.find(id)
    flash[:notice] = "#{beer.name} removed from cart."
    redirect_to cart_index_url
  end

  def update
    id = params[:id]
    beer_quantities = session[:cart]
    beer_quantities[id] -= 1
    session[:cart] = beer_quantities

    if beer_quantities[id].zero?
      destroy
    else
      redirect_to cart_index_url
    end
  end

  def index
    @beer_quantities = session[:cart]
    @beers = Beer.find(@beer_quantities.keys.uniq)
    @total = 0
    @beers.each do |beer|
      @total += beer.price * @beer_quantities[beer.id.to_s]
    end
  end
end
