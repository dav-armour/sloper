# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

brands = %w(burton lib-tech salomon dc volcom capita dakine ripcurl quicksilver )

50.times do
  character = Faker::GameOfThrones.character.split
  user = User.create(
    first_name: character.first,
    last_name: character.last,
    email: Faker::Internet.email,
    password: 'testing123',
    phone: Faker::PhoneNumber.cell_phone
  )
  puts "User created: #{character.first}."
  listing = Listing.create(
    user_id: user.id,
    title: Faker::RockBand,
    description: Faker::Lorem.paragraphs(3),
    category: rand(2),
    item_type: rand(6),
    size: rand(50) + 120,
    brand: brands[rand(9)],
    bindings: Faker::Boolean.boolean,
    boots: Faker::Boolean.boolean,
    helmet: Faker::Boolean.boolean,
    daily_price: rand(100) + 1,
    weekly_price: rand(100) + 1
  )
  puts "Listing created: #{listing.brand}."
  location = Location.create(
    address: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    postcode: Faker::Address.postcode,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    listing_id: listing.id
  )
  puts "Locationcreated: #{location.city}."
  date = Date.new(2018,11,1)
  90.times do
    AvailableDay.create(
      day: date,
      listing_id: listing.id
    )
    date += 1
  end
end

# 30.times do
#   user = User.order("RANDOM()").limit(1)
#   listing = Listing.order("RANDOM()").limit(1)
#   Booking.create(
#     user_id: user.id,
#     listing_id: listing.id
#     start_date: listing.available_days
#   )
# end