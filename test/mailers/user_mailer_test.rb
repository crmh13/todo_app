require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "create_user" do
    user = users(:piyo)
    admin = users(:hoge)
    mail = UserMailer.create_user(user, admin)
    assert_equal "新規ユーザー登録がされました", mail.subject
    assert_equal [admin.email], mail.to
    assert_equal ["noreply@nfvsxpqbegwp.herokuapp.com"], mail.from
    assert_match user.name, mail.body.encoded.split(/\r\n/).map{|i| Base64.decode64(i)}.join
  end

  test "add_mail" do
    user = users(:piyo)
    admin = users(:hoge)
    mail = UserMailer.add_mail(user, admin)
    assert_equal "メールアドレスの登録/Todoアプリ", mail.subject
    assert_equal [user.email], mail.to
    assert_equal [admin.email], mail.bcc
    assert_equal ["noreply@nfvsxpqbegwp.herokuapp.com"], mail.from
    assert_match user.name, mail.body.encoded.split(/\r\n/).map{|i| Base64.decode64(i)}.join
  end

  test "task_schedule" do
    user = users(:hoge)
    name = user.name
    tasks = user.tasks.where(scheduled_date: Date.today).where.not(status: 2).where(send_mail: true)
    mail = UserMailer.task_schedule(user, name, tasks)
    assert_equal "通知メール/Todoアプリ", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@nfvsxpqbegwp.herokuapp.com"], mail.from
    assert_equal 2, tasks.count
    assert_match name, mail.body.encoded.split(/\r\n/).map{|i| Base64.decode64(i)}.join
  end

end
