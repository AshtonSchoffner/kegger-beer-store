# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "csv"

file = File.join(Rails.root, "db", "liquor_mart.csv")
data = File.read(file)
beer_data = CSV.parse(data, headers: true)

Beer.destroy_all
Brewer.destroy_all
Country.destroy_all
Subcategory.destroy_all
Category.destroy_all

beer_data.each do |beer|
  country = Country.find_or_create_by(
    name: beer["country"]
  )

  unless country.valid?
    puts "Could not create country"
    puts country.errors.messages
  end

  name = beer["brewer"]
  name = beer["brewer2"] if name == "null"

  brewer = country.brewer.find_or_create_by(
    name: name
  )

  unless brewer.valid?
    puts "Could not create brewer"
    puts brewer.errors.messages
  end

  categories = beer["category"].split(">")

  category = Category.find_or_create_by(
    name: categories[1].strip
  )

  unless category.valid?
    puts "Could not create category"
    puts category.errors.messages
  end

  subcategory = category.subcategories.find_or_create_by(
    name: categories[2].strip
  )

  unless subcategory.valid?
    puts "Could not create subcategory"
    puts subcategory.errors.messages
  end

  description = beer["description"]
  description = beer["description2"] if description == "null"

  price = beer["retail_price"] if price == "null"

  if beer["retail_price"] != "null"
    prices = beer["retail_price"].split("REG.")
    price = prices[1].strip
  else
    price = beer["price"]
  end

  sizes = beer["size"].split("|")
  size = sizes[2]
  size = sizes[1] if sizes.length == 2

  beer = brewer.beer.create(
    name:           beer["name"],
    description:    description,
    subcategory_id: subcategory.id,
    alcohol_vol:    beer["alcohol"],
    price:          price,
    size:           size.strip,
    quantity:       rand(151)
  )

  unless beer.valid?
    puts "Could not create beer"
    puts beer.errors.messages
  end
end

# if Rails.env.development?
#   AdminUser.create!(email: "admin@example.com", password: "password", password_confirmation: "password")
# end
