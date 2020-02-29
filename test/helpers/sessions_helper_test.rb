require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @user = users(:hoge)
    remember(@user)
  end

  test "current_user永続的セッションテスト" do
    assert_equal @user, current_user
    assert is_logged_in?
  end

  test "current_user rememberがない場合のテスト" do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end
end