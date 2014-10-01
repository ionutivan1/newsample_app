namespace :db do

  include ActionDispatch::TestProcess

  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
    make_messages
    add_profile_pictures
  end
end

def make_users
  admin = User.create!(name:     "Example admin",
                       email:    "iivan@pitechnologies.ro",
                       password: "asdasd",
                       password_confirmation: "asdasd",
                       admin: true,
                      notification: true,
                      state: true)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password,
                 state: true)
  end
end

def add_profile_pictures

  users = User.all
  image =  fixture_file_upload('public/upload/pix/blue.gif', 'image/gif')
  users.each { |user| Image.create!(element: "user", element_id: user.id, image: image) }
end

def make_microposts
  users = User.all(limit: 6)
  50.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end
end

def make_messages
  users = User.all(limit: 6)
  10.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.messages.create!( user_id: user.id, sender_id: user.id, content: content, seen: false) }
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow(followed) }
  followers.each      { |follower| follower.follow(user) }
end