require 'test_helper'

class DetailsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @detail = details(:not_work)
  end

  test "ログイン済みのユーザーでなくては追加できない" do
    assert_no_difference 'Detail.count' do
      post details_path, params: { detail: { content: "未作業タスク" } }
    end
    assert_redirected_to login_url
  end

  test "ログイン済みのユーザーでなくては削除できない" do
    assert_no_difference 'Detail.count' do
      delete detail_path(@detail)
    end
    assert_redirected_to login_url
  end

  test "ログイン済みのユーザーでなくては更新できない" do
    patch detail_path(@detail), params: { detail: { content: "確認テスト" } }
    assert_not_equal "確認テスト", @detail.content
  end

  test "他のユーザーでは削除できない" do
    log_in_as(users(:piyo))
    assert_no_difference 'Detail.count' do
      delete detail_path(@detail)
    end
    assert_redirected_to root_url
  end

  test "他のユーザーでは更新できない" do
    log_in_as(users(:piyo))
    patch detail_path(@detail), params: { detail: { content: "確認テスト" } }
    assert_not_equal "確認テスト", @detail.content
  end
end
