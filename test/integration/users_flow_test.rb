# test/integration/users_flow_test.rb

require "test_helper"

class UsersFlowTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
  end

  test "should get index" do
    get users_index_url
    assert_response :success
  end
end
