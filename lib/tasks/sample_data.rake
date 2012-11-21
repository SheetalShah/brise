namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_relationships
  end
end

def make_users
  admin = User.create!(display_name:     "SheetalShah",
                       email:    "onlysheetal@gmail.com",
                       password: "starry239",
                       password_confirmation: "starry239")
  
  99.times do |n|
    display_name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(display_name:     display_name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..20]
  followers      = users[3..20]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end

