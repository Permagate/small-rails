require 'faker'

users = []
10.times do |n|
  users << User.create(email: "user#{n}@example.com", username: Faker::Internet.user_name, password: 'password')
end

stories = []
100.times do |n|
  stories << Story.create(title: Faker::Name.title, body: Faker::Lorem.paragraph(30 + rand(70)), user: users[n / 10])
end

comments = []
300.times do |n|
  Comment.create(content: Faker::Lorem.paragraph(10), story: stories[n / 3], user: users.sample)
end
