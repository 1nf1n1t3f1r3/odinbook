require "test_helper"

class CommentTest < ActiveSupport::TestCase
  test "user can create comment" do
    user = users(:one)
    post = posts(:one)

    comment = Comment.new(content: "nice post", user: user, post: post)

    assert comment.save
  end

  test "comment belongs to user and post" do
    user = users(:one)
    post = posts(:one)

    comment = Comment.create!(content: "hi", user: user, post: post)

    assert_equal user, comment.user
    assert_equal post, comment.post
  end
end
