require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
    @user.items.create!(title:"test title",content: "Lorem ipsum")
  end

  test "profile display" do
    log_in_as(@user)
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    @user.items.page(1).each do |item|
      assert_match item.content, response.body
    end
  end
end