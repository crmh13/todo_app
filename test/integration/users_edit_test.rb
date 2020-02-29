require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:piyo)
    @admin = users(:hoge)
  end

  test "編集失敗テスト" do
    log_in_as(@user)
    get edit_user_path(@user)
    patch user_path(@user), params: { user: { name: "", password: "foo",
                                      password_confirmation: "bar" } }
    assert_select 'ul.alert'
  end

  test "編集成功テスト" do
    get edit_user_path
    log_in_as(@user)
    assert_redirected_to edit_user_path
    assert_nil session[:forwarding_url]
    get edit_user_path(@user)
    patch user_path(@user), params: { user: { name: name, password: "",
                                      password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to user_path
    @user.reload
    assert_equal name, @user.name
  end

  test "管理ユーザーのみindexにアクセスできる" do
    log_in_as(@user)
    get users_path
    assert_redirected_to root_url
    log_in_as(@admin)
    get user_path
    assert_match 'ユーザー一覧', response.body
  end

  test "管理ユーザーのみ管理用エディットページにアクセスできる" do
    log_in_as(@user)
    get "/admin/#{@user.id}/edit"
    assert_redirected_to root_url
    log_in_as(@admin)
    get "/admin/#{@user.id}/edit"
    assert_match '更新する', response.body
  end

  test "管理ユーザー以外で他のユーザーを編集できない" do
    log_in_as(@user)
    name = "test"
    patch "/users/#{@admin.id}", params: { user: { name: name, password: "",
                                           password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to user_path
    @admin.reload
    assert_not_equal name, @admin.name
  end

  test "管理ユーザーでは他のユーザーを編集できる" do
    log_in_as(@admin)
    name = "test"
    patch "/users/#{@user.id}", params: { user: { name: name, password: "",
                                           password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to users_path
    @user.reload
    assert_equal name, @user.name
  end
end
