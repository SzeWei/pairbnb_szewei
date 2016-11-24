# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do 
	user = User.new
	user.first_name = Faker::Name.first_name
	user.last_name = Faker::Name.last_name
	user.email = Faker::Internet.email
	user.password = "1234"
		if user.save
			number_of_listing = rand(0..3)
			number_of_listing.times do
				listing = Listing.new
				listing.name = Faker::Company.name
				listing.description = Faker::Company.catch_phrase
				listing.address = Faker::Address.country
				listing.price = Faker::Number.between(30, 1000)
				user.listings << listing
				user.save
			end
		end

end 