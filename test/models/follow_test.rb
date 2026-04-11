# test/models/follow_test.rb

require "test_helper"

class FollowTest < ActiveSupport::TestCase
  # Followers Logic
  test "user can follow another user" do
    user1 = users(:one)
    user2 = users(:two)

    Follow.create!(follower: user1, followed: user2)

    assert_includes user1.following_relationships.map(&:followed), user2
  end

  test "user cannot follow themselves" do
    user = users(:one)
    follow = Follow.new(follower: user, followed: user)

    assert_not follow.valid?
  end

  test "user cannot follow same person twice" do
    user1 = users(:one)
    user2 = users(:two)

    Follow.create!(follower: user1, followed: user2)
    duplicate = Follow.new(follower: user1, followed: user2)

    assert_not duplicate.valid?
  end
end
