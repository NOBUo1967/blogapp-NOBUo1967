# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ada = User.create!(email: 'ada@example.com', password: 'password')
carlos = User.create!(email: 'carlos@wxample.com', password: 'password')

5.times do
    ada.articles.create(
      title: Faker::Lorem.sentence(word_count: 5),
      content: Faker::Lorem.sentence(word_count: 100)
    )
end

5.times do
    carlos.articles.create(
      title: Faker::Lorem.sentence(word_count: 5),
      content: Faker::Lorem.sentence(word_count: 100)
    )
end
