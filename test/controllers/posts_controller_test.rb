require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
  end

  test "should get index" do
    get posts_index_url
    assert_response :success
  end

  test "logged in user can create a post" do
    sign_in users(:one)

    assert_difference("Post.count", 1) do
      post posts_url, params: { post: { content: "Hello!" } }
    end

    assert_response :redirect
  end

  test "user can delete their own post" do
    user = users(:one)
    post_record = posts(:one)

    sign_in user

    assert_difference("Post.count", -1) do
      delete post_url(post_record)
    end
  end
end
