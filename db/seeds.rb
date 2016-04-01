# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'random_data'

Post.find_or_create_by(title: "find_or_create_by Title", body: "find_or_create_by Body")
Comment.find_or_create_by(post: Post.find_or_create_by(title: "find_or_create_by Title", body: "find_or_create_by Body"), body: "Comment Body")
#Create Posts
50.times do
  Post.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )
end
posts = Post.all
puts "#{Post.count} posts created"

#Create Comments
100.times do
  Comment.create!(
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end
puts "#{Comment.count} comments created"

15.times do
  Advertisement.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph,
    price: rand(50..100)
  )
end
puts "#{Advertisement.count} Advertisements created"


puts "Seed finished"
