# test/models/post_test.rb

require "test_helper"

class PostTest < ActiveSupport::TestCase
  # Posts Logic
  test "user can create post" do
    user = users(:one)

    post = Post.new(content: "hello", user: user)

    assert post.save
  end

  test "post belongs to user" do
    user = users(:one)
    post = Post.create!(content: "hello", user: user)

    assert_equal user, post.user
  end

  test "user cannot delete another users post" do
    user1 = users(:one)
    user2 = users(:two)

    post = Post.create!(content: "secret", user: user1)

    assert_raises(ActiveRecord::RecordNotFound) do
      user2.posts.find(post.id)
    end
  end
end
