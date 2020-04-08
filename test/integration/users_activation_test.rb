require 'test_helper'

class UsersActivationTest < ActionDispatch::IntegrationTest
  def setup
    @admin=users(:michael)
    @non_user=users(:malory)
  end

  test "index and show is only active users" do
    log_in_as(@admin)
    assert_not @non_user.activated?
    get users_path
    assert_select "a[href=?]",user_path(@non_user), count:0
    get user_path(@non_user)
    assert_redirected_to root_url
  end
end 

