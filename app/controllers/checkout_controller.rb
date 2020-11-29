class CheckoutController < ApplicationController
  helper_method :calculate_subtotal

  def index
    @province = Province.find(params[:province])
    @beer_quantities = session[:cart]
    @beers = Beer.find(@beer_quantities.keys.uniq)
    @subtotal = calculate_subtotal
    @gst = @subtotal * (@province.gst / 100)
    @pst = @subtotal * (@province.pst / 100)
    @hst = @subtotal * (@province.hst / 100)
    @total = @subtotal + @gst + @pst + @hst
  end

  def calculate_subtotal
    subtotal = 0

    @beers.each do |beer|
      subtotal += beer.price * @beer_quantities[beer.id.to_s]
    end
    subtotal
  end
end
