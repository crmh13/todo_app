require 'test_helper'

class UserGraphTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:piyo)
  end
  
  # test "ユーザーページの集計テスト（登録タスク数）" do
  #   log_in_as(@user)
  #   get user_path
  #   assert_match "１ヶ月で登録したタスク数 ： 2", response.body
  # end

  test "ユーザーページの集計テスト（完了タスク数）" do
    log_in_as(@user)
    get user_path
    assert_match "１ヶ月で完了したタスク数 ： 2", response.body
  end
end
