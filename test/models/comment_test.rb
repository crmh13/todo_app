require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @task = tasks(:one)
    @comment = @task.comments.build(body: "コメント1")
  end

  test "バリデーションが正しい" do
    assert @comment.valid?
  end

  test "タスクIDがない" do
    @comment.task_id = nil
    assert_not @comment.valid?
  end

  test "bodyがない" do
    @comment.body = "   "
    assert_not @comment.valid?
  end
end
