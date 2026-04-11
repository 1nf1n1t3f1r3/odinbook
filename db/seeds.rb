# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data (optional, but useful while developing)
# -------------------------
# 🔐 PERSISTENT USERS
# -------------------------
main_email = "johne1234@gmail.com"
test_email = "asdfasdf@gmail.com"

persistent_emails = [ main_email, test_email ]

# Keep persistent users, delete everything else
User.where.not(email: persistent_emails).destroy_all
Post.destroy_all
Comment.destroy_all
Like.destroy_all
Follow.destroy_all

# Ensure persistent users exist
main_user = User.find_or_create_by!(email: main_email) do |u|
  u.username = "john"
  u.password = "password"
end

test_user = User.find_or_create_by!(email: test_email) do |u|
  u.username = "testuser"
  u.password = "password"
end

# -------------------------
# 👥 RANDOM USERS
# -------------------------
users = []

10.times do |i|
  users << User.create!(
    email: "user#{i + 1}@example.com",
    username: "user#{i + 1}",
    password: "password"
  )
end

users += [ main_user, test_user ]

# -------------------------
# 📝 POSTS
# -------------------------
posts = []

users.each do |user|
  rand(2..5).times do
    posts << Post.create!(
      content: [
        "Hello world!",
        "My first post!",
        "Rails is fun 😄",
        "Working on Odinbook",
        "Coffee + coding ☕",
        "Just shipped a feature 🚀"
      ].sample,
      user: user
    )
  end
end

# -------------------------
# 💬 COMMENTS
# -------------------------
posts.each do |post|
  rand(1..4).times do
    Comment.create!(
      content: [
        "Nice post!",
        "Totally agree 👍",
        "This is cool",
        "Haha love this",
        "Great work!",
        "Interesting 🤔"
      ].sample,
      user: users.sample,
      post: post
    )
  end
end

# -------------------------
# ❤️ LIKES
# -------------------------
posts.each do |post|
  users.sample(rand(2..6)).each do |user|
    Like.find_or_create_by!(
      user: user,
      post: post
    )
  end
end

# -------------------------
# 👥 FOLLOWS
# -------------------------
users.each do |user|
  (users - [ user ]).sample(rand(2..5)).each do |other_user|
    Follow.find_or_create_by!(
      follower: user,
      followed: other_user
    )
  end
end

# -------------------------
# 🎯 ENSURE TEST SCENARIO
# -------------------------

# Make sure YOU follow test_user
Follow.find_or_create_by!(
  follower: main_user,
  followed: test_user
)

# Make sure test_user follows YOU
Follow.find_or_create_by!(
  follower: test_user,
  followed: main_user
)

puts "✅ Seeded successfully!"
