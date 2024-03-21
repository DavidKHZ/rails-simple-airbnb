# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts 'Cleaning database...'
Flat.destroy_all

puts 'Creating Fake flats'

4.times do
  flat = Flat.create!(
    address: Faker::Address.full_address,
    description: Faker::Restaurant.review,
    price_per_night: rand(25..500),
    number_of_guests: rand(1..15)
  )
  flat_street = flat.address.split(',')[0]
  flat_city = flat.address.split(',')[1].strip
  flat[:name] = "Lovely flat on #{flat_street}, #{flat_city}"
  flat.save!
  puts "Created #{flat.name}"
  puts "#{flat.number_of_guests} guest#{'s' if flat.number_of_guests > 1} maximum"
  puts "#{flat.price_per_night} €/night"
  puts flat.description
end

puts 'Done with creating Fake flats'
