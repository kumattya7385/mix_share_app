require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get sinup_path
    assert_response :success
  end

end
