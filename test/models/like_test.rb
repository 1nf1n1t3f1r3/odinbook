require "test_helper"

class LikeTest < ActiveSupport::TestCase
  # Like Logic


  test "user can like a post" do
    user = users(:one)
    post = posts(:one)

    Like.create!(user: user, post: post)

    assert_includes post.likes.map(&:user), user
  end

  test "user cannot like same post twice" do
    user = users(:one)
    post = posts(:one)

    Like.create!(user: user, post: post)

    duplicate = Like.new(user: user, post: post)

    assert_not duplicate.valid?
    assert_includes duplicate.errors[:user], "has already been taken"
  end

  test "post like count is accurate" do
    user = users(:one)
    post = posts(:one)

    Like.create!(user: user, post: post)

    assert_equal 1, post.likes.count
  end
end
