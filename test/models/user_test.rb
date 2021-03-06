# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  activated         :boolean          default(FALSE)
#  activated_at      :datetime
#  activation_digest :string
#  admin             :boolean          default(FALSE)
#  content           :string
#  email             :string
#  name              :string
#  password_digest   :string
#  remember_digest   :string
#  reset_digest      :string
#  reset_sent_at     :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#  index_users_on_name   (name) UNIQUE
#
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  #テスト用の仮のユーザ作成
  def setup
    @user = User.new(name: "example user", email: "user@example.com",password: "foobar", password_confirmation: "foobar")
    @user1 = User.new(name: "example User", email: "user1@example.com",password: "foobar", password_confirmation: "foobar")
  end

  #アカウント作成用のテスト
  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name="      "
    assert_not @user.valid?
  end

  test "name should be unique case sensitive" do
    duplicate_user=@user.dup
    @user.save
    assert_not @user1.valid?
    duplicate_user.name=@user.name.upcase
    assert duplicate_user
  end

  test "email should be present" do
    @user.email="      "
    assert_not @user.valid?
  end

  test "emial should not be too long" do
    @user.email="a"*244+"@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    duplicate_user.email=@user.email.upcase
    assert_not duplicate_user.valid?
  end

  #DBにemailを保存する時に小文字化しているかチェックするテスト
  test "email addresses should be saved as lower-case" do
    check_email="FooBar@Example.coM"
    @user.email=check_email
    @user.save
    assert_equal check_email.downcase, @user.reload.email
  end

  #passwordテスト
  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember,'')
  end

  test "associated items should be destroyed" do
    @user.save
    @user.items.create!(title:"test title",content: "Lorem ipsum")
    assert_difference 'Item.count', -1 do
      @user.destroy
    end
  end

end
