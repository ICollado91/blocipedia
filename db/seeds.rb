# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
arr = []
50.times do
    User.create!(
        email: Faker::Internet.unique.email,
        password: Faker::Address.city
    )
    arr.push(User.last)
end

100.times do
    Wiki.create!(
        title: Faker::Hipster.unique.sentence,
        body: Faker::Hipster.paragraph,
        private: false,
        user_id: arr.sample.id
    )
end

puts "#{User.count} users were created!"
puts "#{Wiki.count} wikis were created!"