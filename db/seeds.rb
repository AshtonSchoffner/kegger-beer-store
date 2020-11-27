require "csv"

file = Rails.root.join("db/liquor_mart.csv")
data = File.read(file)
beer_data = CSV.parse(data, headers: true)
blank_values = ["null", "", "NULL"]

file = Rails.root.join("db/provinces.csv")
data = File.read(file)
province_data = CSV.parse(data, headers: true)

Beer.destroy_all
Brewer.destroy_all
Country.destroy_all
Subcategory.destroy_all
Category.destroy_all
Province.destroy_all

province_data.each do |province|
  hst = province["hst"] ||= 1
  pst = province["pst"] ||= 1
  gst = province["gst"] ||= 1

  Province.create(
    name: province["name"],
    gst:  province["gst"],
    pst:  province["pst"],
    hst:  province["hst"]
  )
end

beer_data.each do |beer|
  country = Country.find_or_create_by(
    name: beer["country"]
  )

  unless country.valid?
    puts "Could not create country"
    puts country.errors.messages
  end

  name = beer["brewer"]
  name = beer["brewer2"] if blank_values.include?(name)
  name = "Unknown Brewer" if blank_values.include?(name)

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
  description = beer["description2"] if blank_values.include?(description)

  if beer["retail_price"] != "null"
    prices = beer["retail_price"].split("REG. $")
    price = prices[1].strip
  else
    price = beer["price"].strip
  end
  price.delete!("$")

  sizes = beer["size"].split("|")
  size = sizes[2]
  size = sizes[1] if sizes.length == 2

  beer = brewer.beer.create(
    name:           beer["name"],
    description:    description,
    subcategory_id: subcategory.id,
    alcohol_vol:    beer["alcohol"],
    price:          price.to_f,
    size:           size.strip,
    quantity:       rand(151)
  )

  unless beer.valid?
    puts "Could not create beer"
    puts beer.errors.messages
  end
end

if Rails.env.development?
  AdminUser.create!(email:                 "admin@example.com",
                    password:              "password",
                    password_confirmation: "password")
end
