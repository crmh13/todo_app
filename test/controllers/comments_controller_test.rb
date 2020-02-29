require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @comment = comments(:one)
  end

  test "ログイン済みのユーザーでなくては追加できない" do
    assert_no_difference 'Comment.count' do
      post comments_path, params: { comment: { body: "コメント1" } }
    end
    assert_redirected_to login_url
  end

  test "ログイン済みのユーザーでなくては削除できない" do
    assert_no_difference 'Comment.count' do
      delete comment_path(@comment)
    end
    assert_redirected_to login_url
  end

  test "他のユーザーでは削除できない" do
    log_in_as(users(:piyo))
    assert_no_difference 'Comment.count' do
      delete comment_path(@comment)
    end
    assert_redirected_to root_url
  end
end
