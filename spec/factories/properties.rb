FactoryBot.define do
  factory :property do
    headline { "Test property" }
    description { "This is a test property" }
    street { "Street W" }
    city { "City X" }
    state { "State Y"}
    country { "Country Z"}
    latitude { 10 }
    longitude { 10 }
    status { "active" }
    owner factory: :user 
    price { 200 }
  end
end
