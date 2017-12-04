# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Author.create!(name: 'Admin Author',
               email: 'admin@sharedblog.com',
               password: 'P@ssw0rd',
               password_confirmation: 'P@ssw0rd',
               admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example.#{n + 1}@sharedblog.com"
  password = 'password'
  Author.create!(name:  name,
                 email: email,
                 password: password,
                 password_confirmation: password)
end

authors = Author.order(:created_at).take(6)
50.times do
  title = Faker::Lorem.sentence(5)
  content = Faker::Lorem.sentence(100)
  authors.each { |author| author.articles.create!(title: title, content: content) }
end

# Following relationships
authors = Author.all
author  = authors.first
following = authors[2..50]
followers = authors[3..40]
following.each { |followed| author.follow(followed) }
followers.each { |follower| follower.follow(author) }

# Favoring
authors = Author.all
articles = Article.all
articles1 = articles[1..25]
articles2 = articles[26..50]
author1 = authors.first
author2 = authors.last

articles1.each do |article|
  author1.favorite(article)
end

articles2.each do |article|
  author2.favorite(article)
end