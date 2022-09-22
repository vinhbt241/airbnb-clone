FactoryBot.define do
  factory :reservation do
    from { Date.today}
    to { Date.today + 5.day }
    status { "processing" }

    property
    user
  end
end
