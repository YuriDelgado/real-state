FactoryBot.define do
  factory :realstate do
    name { Faker::Lorem.paragraph }
    street { Faker::Address.street_name }
    city { Faker::Address.city }
    external_number { "4343-DER" }
    internal_number { "sdfg-D345" }
    country { Faker::Address.country_code.downcase }
    neighborhood { Faker::Address.community }
    category { :department }
    rooms {rand(1..5)}
    bathrooms { 2 }
    comments { Faker::Lorem.paragraph }
  end
end
