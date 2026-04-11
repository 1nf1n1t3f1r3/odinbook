# test/integration/auth_test.rb

require "test_helper"

class AuthTest < ActionDispatch::IntegrationTest
  test "redirects when not logged in" do
    get posts_url
    assert_response :redirect
  end
end
