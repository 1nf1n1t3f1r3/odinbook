# test/models/user_test.rb
require "test_helper"

class UserTest < ActiveSupport::TestCase
  # Username, Devise, Auth
  test "username must be unique" do
    user1 = User.create!(username: "john", email: "john1@test.com", password: "password")
    user2 = User.new(username: "john", email: "john2@test.com", password: "password")

    assert_not user2.valid?
    assert_includes user2.errors[:username], "has already been taken"
  end

    test "email must be unique" do
    user1 = User.create!(username: "john1", email: "john1@test.com", password: "password")
    user2 = User.new(username: "john2", email: "john1@test.com", password: "password")

    assert_not user2.valid?
    assert_includes user2.errors[:email], "has already been taken"
  end

  test "user can authenticate with correct password" do
    user = User.create!(username: "john", email: "john@test.com", password: "password")

    assert user.valid_password?("password")
  end

  # # Feed
  # test "feed includes posts from user and followed users" do
  #   user = users(:one)
  #   followed = users(:two)

  #   Follow.create!(follower: user, followed: followed)

  #   own_post = Post.create!(content: "mine", user: user)
  #   followed_post = Post.create!(content: "theirs", user: followed)

  #   feed_posts = Post.where(user: [ user ] + user.following_relationships.map(&:followed))

  #   assert_includes feed_posts, own_post
  #   assert_includes feed_posts, followed_post
  # end
end
