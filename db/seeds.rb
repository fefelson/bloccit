require 'random_data'

#Create Users
5.times do |i|
  User.create!(
    name: "#{i} " + RandomData.random_name,
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
    password: 'helloworld',
    role: 'admin'
  )
end

unless User.find_by(email: 'member@example.com')
  User.create!(
    name: 'Member User',
    email: 'member@example.com',
    password: 'helloworld'
  )
end

unless User.find_by(email: 'member@example.com')
  User.create!(
    name: 'Member User',
    email: 'member@example.com',
    password: 'helloworld'
  )
end

users = User.all
puts "#{users.count} users created."

#Create Labels
unless Label.all.any?
  label_names = %w(rogue red gold viper wolf bandit yellow blade blue dantooine)
  label_names.each do |label_name|
    Label.create!(
      name: label_name
      )
  end
end
labels = Label.all

#Create Topics
25.times do |i|
  Topic.create!(
    name: "#{i} " + RandomData.random_sentence,
    description: RandomData.random_paragraph,
    labels: rand(0..5).times.map { labels.sample }.uniq  
  )
end
topics = Topic.all
puts "#{topics.count} topics created."

#Create Posts
100.times do |i|
  post = Post.create!(
    user: users.sample,
    topic: topics.sample,
    title: "#{i} " + RandomData.random_sentence,
    body: RandomData.random_paragraph,
    labels: rand(0..5).times.map { labels.sample }.uniq  
  )
  post.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
  rand(1..5).times { post.votes.create!(value: [-1,1].sample, user: users.sample)}
end
posts = Post.all
puts "#{posts.count} posts created."
puts "#{Vote.count} votes created."

#Create Comments
200.times do |i|
  Comment.create!(
    user: users.sample,
    post: posts.sample,
    body: "#{i} " + RandomData.random_paragraph
  )
end
puts "#{Comment.count} comments created"

puts "Seed finished"
<<<<<<< HEAD
=======

>>>>>>> xm_42_checkpoint
