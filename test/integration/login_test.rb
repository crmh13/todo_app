require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:hoge)
  end

  test "ログイン情報が正しくない" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params:{ name: '', password: '' }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "ユーザーログインテスト" do
    get login_path
    post login_path, params: { name: @user.name, password: 'password' }
    assert is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_template 'home/index'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path
    get logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # 2番目のウィンドウでログアウトをクリックするユーザーをシミュレートする
    get logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "ログイン情報の記憶" do
    log_in_as(@user, remember_me: '1')
    assert_equal cookies['remember_token'], assigns(:user).remember_token
  end

  test "ログイン情報チェックボックステスト" do
    log_in_as(@user, remember_me: '1')
    get logout_path
    log_in_as(@user, remember_me: '0')
    assert_empty cookies['remember_token']
  end
end
