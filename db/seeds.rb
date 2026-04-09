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
your_email = "johne1234@gmail.com"

# Keep your user, delete others
User.where.not(email: your_email).destroy_all
Post.destroy_all

# Create additional users
10.times do |i|
  user = User.create!(
    email: "user#{i + 1}@example.com",
    username: "user#{i + 1}",
    password: "password"
  )

  rand(2..5).times do
    Post.create!(
      content: [
        "Hello world!",
        "My first post!",
        "Rails is fun 😄",
        "Working on Odinbook",
        "Coffee + coding ☕"
      ].sample,
      user: user
    )
  end
end

# Give YOUR user some posts too
current_user = User.find_by(email: your_email)

if current_user
  3.times do |i|
    Post.create!(
      content: "My personal post #{i + 1}",
      user: current_user
    )
  end
end
