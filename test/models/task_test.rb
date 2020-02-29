require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  def setup
    @user = users(:hoge)
    @task = @user.tasks.build(title: "タイトル1")
  end

  test "バリデーションが正しい" do
    assert @task.valid?
  end

  test "ユーザーIDがない" do
    @task.user_id = nil
    assert_not @task.valid?
  end

  test "タイトルがない" do
    @task.title = "   "
    assert_not @task.valid?
  end

  test "期日が早い順に並んでいるかどうか" do
    assert_equal tasks(:piyopiyo), Task.first
  end
end
