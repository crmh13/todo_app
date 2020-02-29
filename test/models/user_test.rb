require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "hoge", password: "hogehoge")
  end

  test "user_validates" do
    assert @user.valid?
  end

  test "user.nameが空だとＮＧ" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "user.name50文字以内" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end
  
  test "user.name一意性のテスト" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "user.passwordが空だとＮＧ" do
    @user.password_digest = ""
    assert_not @user.valid?
  end

  test "digestが存在しない場合のテスト" do
    assert_not @user.authenticated?('')
  end

  test "ユーザーを削除したときタスクも削除されるか" do
    @user.save
    @user.tasks.create!(title: "hogehoge")
    assert_difference "Task.count", -1 do
      @user.destroy
    end
  end

end
