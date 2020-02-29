User.create!(name: "管理ユーザー", email: "t260robo@gmail.com",
             password: "admin_TodoApp3526",
             password_confirmation: "admin_TodoApp3526",
             admin: true)

User.create!(name: "テストユーザー", email: "229ue6@bma.biglobe.ne.jp",
             password: "test123456",
             password_confirmation: "test123456")

user = User.find_by(name: "テストユーザー")
50.times do
  user.tasks.create!(title: "テストタスク", scheduled_date: Date.tomorrow)
end
user.tasks.create!(title: "未作業タスク", created_at: Date.new(2018,6,27))
user.tasks.create!(title: "未作業タスク", created_at: Date.new(2018,6,28))
user.tasks.create!(title: "未作業タスク", scheduled_date: Date.today + 3)
user.tasks.create!(title: "作業済みタスク", scheduled_date: Date.today - 1, status: 2, completion_date: Date.today - 1)
user.tasks.create!(title: "メール送信テスト作業中タスク", scheduled_date: Date.today, status: 1, send_mail: true)
user.tasks.create!(title: "メール送信テスト未作業タスク", scheduled_date: Date.today, status: 0, send_mail: true)
user.tasks.create!(title: "メール送信テスト完了タスク", scheduled_date: Date.today, status: 2, send_mail: true)

task = Task.find_by(title: "未作業タスク")
task.details.create!(content: "未作業テスト")
task.details.create!(content: "作業中テスト", status: 1)
task.details.create!(content: "作業済みテスト", status: 2)
task.comments.create!(body: "コメント1")
task.comments.create!(body: "コメント2")
task.comments.create!(body: "コメント3\n改行")