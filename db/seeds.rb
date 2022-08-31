require 'faker'

tag_icon_paths = Dir["app/assets/images/tag/*"]
tag_icon_paths.map do |path|
  icon_file = path.split("/")[-1]
  Tag.create(
    name: icon_file.split(".")[0].split("_").join(" ").capitalize,
    icon_path: icon_file
  )
end

20.times do 
  property_name = Faker::Address.street_name
  Property.create(
    name: property_name, 
    headline: property_name, 
    description: Faker::Lorem.paragraph,
    street: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country: Faker::Address.country
  )
end
