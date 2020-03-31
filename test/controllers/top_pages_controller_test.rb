require 'test_helper'

class TopPagesControllerTest < ActionDispatch::IntegrationTest
  
  test "should get root" do
    get root_url
    assert_response :success
  end
  test "should get home" do
    get top_pages_home_url
    assert_response :success
    assert_select "title", "Vmixsh"
  end

  test "should get contact" do
    get top_pages_contact_url
    assert_response :success
    assert_select "title", "問い合わせ - Vmixsh"
  end
end
