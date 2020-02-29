require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user       = users(:hoge)
    @other_user = users(:piyo)
  end

  # test "should redirect edit when logged in as wrong user" do
  #   log_in_as(@other_user)
  #   get edit_user_path(@user)
  #   assert flash.empty?
  #   assert_redirected_to root_url
  # end

  # test "should redirect update when logged in as wrong user" do
  #   log_in_as(@other_user)
  #   patch user_path(@user), params: { user: { name: @user.name,
  #                                             email: @user.email } }
  #   assert flash.empty?
  #   assert_redirected_to root_url
  # end

  test "管理権限を与えられないことのテスト" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: { user: { password: @other_user.password,
                                                    password_confirmation: @other_user.password,
                                                    admin: true } }
    assert_not @other_user.reload.admin?
  end

  test "ログインしていない場合に削除ができない" do
    assert_no_difference 'User.count' do
      delete user_path
    end
    assert_redirected_to login_url
  end

  test "管理ユーザーが他人のユーザーを削除できる" do
    log_in_as(@user)
    assert_difference 'User.count', -1 do
      delete "/users/#{@other_user.id}"
    end
    assert_redirected_to users_path
  end

  test "管理ユーザー以外が他人のユーザーを削除できない" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete "/users/#{@user.id}"
    end
    assert_redirected_to root_path
  end
end
