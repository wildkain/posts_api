# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

#Users
3.times do
  User.create(
          nickname: Faker::Name.unique.name,
          email: Faker::Internet.free_email,
          password: "password123"
  )
end

#Posts

100.times do
  Post.create(
          title: Faker::Lorem.sentence(10),
          body:  Faker::Lorem.sentence(100),
          author_id: rand(1..3),
          published_at: rand(1.month.ago..Time.now)
  )
end

