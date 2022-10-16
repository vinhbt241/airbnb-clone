require 'faker'

tag_icon_paths = Dir["app/assets/images/tag/*"]
tag_icon_paths.map do |path|
  icon_file = path.split("/")[-1]
  Tag.create(
    name: icon_file.split(".")[0].split("_").join(" ").capitalize,
    icon_path: icon_file
  )
end

admin_1 = User.new(
  email: "exampleadmin@gmail.com",
  password: "admin123",
  password_confirmation: "admin123"
)
admin_1.skip_confirmation! 
admin_1.save

admin_1.add_role :admin

user_1 = User.new(
  email: "exampleuser@gmail.com",
  password: "user123",
  password_confirmation: "user123"
)
user_1.skip_confirmation! 
user_1.save

10.times do |i|
  country = Faker::Address.country
  homestay_coordinates = Geocoder.search(country).first.coordinates

  current_property = Property.create(
    headline: Faker::Quote.famous_last_words,
    description: Faker::Lorem.paragraph,
    street: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country: country,
    latitude: homestay_coordinates[0], 
    longitude: homestay_coordinates[1],
    price: rand(100..1500),
    status: "active",
    owner_id: 2
  )

  5.times do |j|
    current_property.images.attach(
      io: File.open(Rails.root.join("app/assets/images/properties", "property_#{i + 1}", "image_#{j + 1}.webp")), 
      filename: "image_#{j + 1}", 
      content_type: "image/webp"
    )
  end

  (5..10).to_a.sample.times do |i|
    Review.create(reviewable: current_property, rating: (1..5).to_a.sample, body: Faker::Lorem.paragraph)
  end
  

  product = Stripe::Product.create({
    name: current_property.headline
  })

  price = Stripe::Price.create({
    unit_amount: current_property.price * 100,
    currency: 'usd',
    product: product.id,
  })

  current_property.product_id = product.id
  current_property.price_id = price.id
  current_property.save
end


