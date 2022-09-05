require 'faker'

tag_icon_paths = Dir["app/assets/images/tag/*"]
tag_icon_paths.map do |path|
  icon_file = path.split("/")[-1]
  Tag.create(
    name: icon_file.split(".")[0].split("_").join(" ").capitalize,
    icon_path: icon_file
  )
end

10.times do |i|
  property_name = Faker::Address.street_name
  current_property = Property.create(
    name: property_name, 
    headline: property_name, 
    description: Faker::Lorem.paragraph,
    street: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country: Faker::Address.country
  )

  current_property.images.attach(
    io: File.open(Rails.root.join("app/assets/images/properties", "p_#{i + 1}.webp")), 
    filename: current_property.name, 
    content_type: "image/webp"
  )
end

admin_1 = User.create(
  email: "exampleadmin@gmail.com",
  password: "admin123",
  password_confirmation: "admin123"
)

admin_1.add_role :admin

user_1 = User.create(
  email: "exampleuser@gmail.com",
  password: "user123",
  password_confirmation: "user123"
)
