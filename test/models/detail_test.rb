require 'test_helper'

class DetailTest < ActiveSupport::TestCase
  def setup
    @task = tasks(:one)
    @detail = @task.details.build(content: "タスク詳細")
  end

  test "バリデーションが正しい" do
    assert @detail.valid?
  end

  test "タスクIDがない" do
    @detail.task_id = nil
    assert_not @detail.valid?
  end

  test "contentがない" do
    @detail.content = "   "
    assert_not @detail.valid?
  end
end
