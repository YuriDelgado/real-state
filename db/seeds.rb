# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
5.times do
  rooms = rand(9)
  rs = nil
  loop do
    rs = Realstate.new( name: Faker::Address.full_address,
                       street: Faker::Address.street_name,
                       city: Faker::Address.city,
                       external_number: Faker::Lorem.words(number: 2).join('-'),
                       internal_number: Faker::Lorem.words(number: 2).join('-'),
                       country: Faker::Address.country_code.downcase,
                       neighborhood: Faker::Address.community,
                       category: %I[house department land commercial_ground].sample,
                       rooms: rooms,
                       bathrooms: (rooms/0.7).truncate(2),
                       comments: Faker::Lorem.paragraph
                      )
    break if rs.valid?
  end
  rs.save
end
