# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

30.times do 
	user = User.create(
		first_name: Faker::Name.first_name,
		last_name: Faker::Name.last_name,
		avatar: Pathname.new(Rails.root + "app/assets/images/avatar/#{rand(1..6)}.png").open, 
		email: Faker::Internet.email,
		password: "1234",
		role: 1
		)
end

User.all.each do |user|
	5.times do 
	  user.listings.create(
	    address: Faker::Address.country,
	    description: Faker::Lorem.paragraph(2),
	    price: rand(50..1000),
	    name: Faker::Company.name
	    )
  end
end

50.times do 
	User.create(
		first_name: Faker::Name.first_name,
		last_name: Faker::Name.last_name,
		avatar: Pathname.new(Rails.root + "app/assets/images/avatar/#{rand(1..6)}.png").open, 
		email: Faker::Internet.email,
		password: "123456",
		role: 2
		)
end

