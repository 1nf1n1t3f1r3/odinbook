# test/integration/posts_flow_test.rb

require "test_helper"

class CommentsFlowTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
  end

  test "user can comment on a post" do
    user = users(:one)
    post = posts(:one)

    sign_in user

    assert_difference("Comment.count", 1) do
      post post_comments_path(post), params: {
        comment: { content: "Nice post!" }
      }
    end

    assert_redirected_to post_path(post)
  end

  test "comment appears on post page" do
    user = users(:one)
    post = posts(:one)

    sign_in user

    post post_comments_path(post), params: {
      comment: { content: "Nice!" }
    }

    get post_path(post)

    assert_select "div", text: /Nice!/
  end
end
