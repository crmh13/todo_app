require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  def setup
    @task = tasks(:one)
  end

  test "ログイン済みのユーザーでなくてはタスクshowを表示できない" do
    get task_path(@task)
    assert_redirected_to login_url
  end

  test "ログイン済みのユーザーでなくてはタスクeditを表示できない" do
    get edit_task_path(@task)
    assert_redirected_to login_url
  end

  test "ログイン済みのユーザーでなくてはタスクnewを表示できない" do
    get new_task_path
    assert_redirected_to login_url
  end

  test "ログイン済みのユーザーでなくてはタスクを投稿できない" do
    assert_no_difference 'Task.count' do
      post tasks_path, params: { task: { title: "タスク1" } }
    end
    assert_redirected_to login_url
  end

  test "ログイン済みのユーザーでなくてはタスクを削除できない" do
    assert_no_difference 'Task.count' do
      delete task_path(@task)
    end
    assert_redirected_to login_url
  end

  test "ログイン済みのユーザーでなくてはタスクを更新できない" do
    patch task_path(@task), params: { task: { title: "タスクテスト" } }
    assert_equal "タイトル1", @task.title
  end

  test "他ユーザーでは削除ができない" do
    log_in_as(users(:piyo))
    assert_no_difference "Task.count" do
      delete task_path(@task)
    end
    assert_redirected_to root_url
  end

  test "他ユーザーではタスクshowを表示できない" do
    log_in_as(users(:piyo))
    get task_path(@task)
    assert_redirected_to root_url
  end

  test "他ユーザーではタスクeditを表示できない" do
    log_in_as(users(:piyo))
    get edit_task_path(@task)
    assert_redirected_to root_url
  end

  test "他ユーザーではタスクを更新できない" do
    log_in_as(users(:piyo))
    patch task_path(@task), params: { task: { title: "タスクテスト" } }
    assert_equal "タイトル1", @task.title
  end

end
