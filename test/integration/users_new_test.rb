require 'test_helper'

class UsersNewTest < ActionDispatch::IntegrationTest
  test "invalid signup" do
    get new_user_path
    assert_no_difference 'User.count' do
      post user_path, params: { user: { name: "", password: "hoge", password_confirmation: "piyo"} }
    end
    assert_template 'users/new'
    assert_select 'ul.alert'
  end

  test "valid signup" do
    get new_user_path
    assert_difference 'User.count', 1 do
      post user_path, params: { user: { name: "hoge", password: "hogehoge", password_confirmation: "hogehoge" } }
    end
    follow_redirect!
    assert_template 'home/index'
    assert_not flash.empty?
    assert is_logged_in?
  end
end
