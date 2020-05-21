# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
50.times do
  title = Faker::Appliance.equipment
  desc = Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false)
  starting_price = rand(0..50)
  end_date = Faker::Date.between(from: Date.today, to: 30.days.from_now)
  user_id = rand(1..2)
  image = Faker::Avatar.image(slug: "my-own-slug", size: "50x50", format: "jpg")
  published_at = Faker::Date.between(from: 5.days.from_now, to: 1.days.from_now)
  draft = Faker::Boolean.boolean
  Auction.create(title: title, desc: desc, starting_price: starting_price, end_date: end_date, user_id: user_id, image: image, published_at: published_at, draft: draft)
end
