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
    title: Faker::RockBand.name,
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
  puts "Location created: #{location.city}."
  date = Date.new(2018,11,1)
  90.times do
    AvailableDay.create(
      day: date,
      listing_id: listing.id
    )
    date += 1
  end
end

puts "generating bookings"
100.times do
  # Select random user and listing
  user = User.find(User.pluck(:id).sample)
  listing = Listing.find(Listing.pluck(:id).sample)
  start_day = rand(0..30)
  num_days = rand(2..14)
  end_day = start_day + num_days
  rented_days = listing.available_days[start_day..end_day]
  Booking.create(
    user_id: user.id,
    listing_id: listing.id,
    start_date: rented_days.first.day,
    end_date: rented_days.last.day,
    booking_date: rented_days.first.day - 7.days,
    total_cost: num_days * listing.daily_price
  )
  # Remove rented days from available days
  AvailableDay.where(id: rented_days.pluck(:id)).destroy_all
end