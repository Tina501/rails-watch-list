# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

# db/seeds.rb

require 'open-uri'
require 'json'
require 'faker'

# Seed Fake Movies using Faker
10.times do
  Movie.create(
    title: Faker::Movie.title,
    overview: Faker::Movie.quote,
    poster_url: Faker::Avatar.image,
    rating: rand(1..10).to_f
  )
end
puts "Fake movies seeded successfully!"

# Fetch top-rated movies from the API
url = 'https://tmdb.lewagon.com/movie/top_rated'
movies_serialized = URI.open(url).read
movies = JSON.parse(movies_serialized)

# Debugging: print out the movies data to see if the API is returning the expected values
puts "Fetched movies from API"

# Iterate over the real movies and create them in the database
movies["results"].each do |movie|
  Movie.create(
    title: movie["title"],
    overview: movie["overview"],
    poster_url: "https://image.tmdb.org/t/p/original/#{movie["poster_path"]}",
    rating: movie["vote_average"]
  )
end

puts "Real movies seeded successfully!"


10.times do
  List.create(name: Faker::Movie.genre)
end

puts "Lists seeded successfully!"
