# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

brands = %w(Burton Lib-Tech Salomon D.C. Volcom Capita Dakine Ripcurl Quicksilver)

50.times do
  character = Faker::HarryPotter.character.split
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
    description: Faker::Lorem.paragraphs(5).join("\n"),
    category: rand(2),
    item_type: rand(6),
    size: rand(50) + 120,
    brand: brands[rand(9)],
    bindings: Faker::Boolean.boolean,
    boots: Faker::Boolean.boolean,
    helmet: Faker::Boolean.boolean,
    daily_price: rand(5..20) * 100,
    weekly_price: rand(20..50) * 100
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
  # Available days added using model scoped after_create_commit
end

puts "generating bookings and reviews"
300.times do |i|
  # Select random user and listing
  puts i
  user = User.find(User.pluck(:id).sample)
  listing = Listing.find(Listing.pluck(:id).sample)
  unavail_days = listing.unavailable_days
  date_range = (3.months.ago.to_date..3.months.from_now.to_date).to_a - unavail_days
  # Select random date range that is valid
  begin
    start_day = date_range.sample
    num_days = rand(2..14)
    end_day = start_day + num_days
  end until ((start_day..end_day).to_a & unavail_days).empty?
  # Create booking
  booking = Booking.create(
    user_id: user.id,
    listing_id: listing.id,
    start_date: start_day,
    end_date: end_day,
    booking_date: start_day - 7.days,
    total_cost: num_days * listing.daily_price,
    stripe_charge_id: 'fake'
  )
  # Create review 70% of the time for past bookings
  if end_day < Time.now.to_date && rand(10) < 7
    print "."
    Review.create(
      booking_id: booking.id,
      rating: rand(1..5),
      content: Faker::Lorem.paragraph(5)
    )
  end
end