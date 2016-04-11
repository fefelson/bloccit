require 'random_data'

Post.find_or_create_by(title: "find_or_create_by Title", body: "find_or_create_by Body")
Comment.find_or_create_by(post: Post.find_or_create_by(title: "find_or_create_by Title", body: "find_or_create_by Body"), body: "Comment Body")

#Create Users
5.times do
  User.create!(
    name: RandomData.random_name,
    email: RandomData.random_email,
    password: RandomData.random_sentence
  )
end

unless User.find_by(email: 'edwrdwalsh@gmail.com')
  user = User.first
  user.update_attributes!(
    email: 'edwrdwalsh@gmail.com',
    password: 'helloworld'
  )
end

unless User.find_by(email: 'admin@example.com')
  User.create!(
    name: 'admin example',
    email: 'admin@example.com',
    password: 'helloworld'
  )
end

users = User.all
puts "#{users.count} users created."

#Create Topics
15.times do
  Topic.create!(
    name: RandomData.random_sentence,
    description: RandomData.random_paragraph
  )
end
topics = Topic.all
puts "#{topics.count} topics created."

#Create Posts
50.times do
  Post.create!(
    user: users.sample,
    topic: topics.sample,
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )
end
posts = Post.all
puts "#{posts.count} posts created."

#Create Comments
100.times do
  Comment.create!(
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end
puts "#{Comment.count} comments created"

puts "Seed finished"

