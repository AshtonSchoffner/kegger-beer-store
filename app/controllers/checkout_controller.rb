class CheckoutController < ApplicationController
  def index
    @province = Province.find(params[:province])
    @beer_quantities = session[:cart]
    @beers = Beer.find(@beer_quantities.keys.uniq)
    @subtotal = calculate_subtotal(@beers, @beer_quantities)
    @taxes = calculate_taxes(@province.gst, @province.pst, @province.hst, @subtotal)
    @total = @subtotal + @taxes["gst"] + @taxes["pst"] + @taxes["hst"]

    order = create_order(@province.id, @taxes, @total)
    create_order_items(order, @beers, @beer_quantities)
  end

  def calculate_subtotal(beers, quantities)
    subtotal = 0

    beers.each do |beer|
      subtotal += beer.price * quantities[beer.id.to_s]
    end
    subtotal
  end

  def create_order(province_id, taxes, total)
    user = User.find(current_user.id)
    user.orders.create(
      province_id: province_id,
      gst:         taxes["gst"],
      pst:         taxes["pst"],
      hst:         taxes["hst"],
      grandtotal:  total,
      address:     current_user[:address]
    )
  end

  def create_order_items(order, beers, quantities)
    beers.each do |beer|
      order.order_items.create(
        price:    beer.price,
        beer_id:  beer.id,
        quantity: quantities[beer.id.to_s]
      )
    end
  end

  def calculate_taxes(pst, gst, hst, subtotal)
    taxes = {}
    taxes["gst"] = subtotal * (gst / 100)
    taxes["pst"] = subtotal * (pst / 100)
    taxes["hst"] = subtotal * (hst / 100)
    taxes
  end
end
