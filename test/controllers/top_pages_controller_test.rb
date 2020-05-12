require 'test_helper'

class TopPagesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end
  test "should get root" do
    get root_path
    assert_response :success
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "問い合わせ - Vmish"
  end
end
