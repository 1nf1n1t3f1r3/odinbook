# test/integration/posts_flow_test.rb

require "test_helper"

class PostsFlowTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @post = posts(:one)
    sign_in @user
  end

  test "logged in user can see posts" do
    get posts_url
    assert_response :success
  end

  test "user can create a post" do
    assert_difference("Post.count", 1) do
      post posts_url, params: { post: { content: "Hello from test" } }
    end

    assert_response :redirect
  end

  test "user can delete their own post" do
    post_record = @user.posts.first || @post

    assert_difference("Post.count", -1) do
      delete post_url(post_record)
    end
  end

  test "user cannot delete another user's post" do
    other_user = users(:two)
    post_record = posts(:one)

    sign_in other_user

    assert_no_difference("Post.count") do
      delete post_url(post_record)
    end
  end
end
