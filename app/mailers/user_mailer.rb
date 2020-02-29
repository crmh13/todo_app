class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.create_user.subject
  #
  def create_user(user, admin)
    @user = user
    @admin = admin

    mail to: admin.email, subject: "新規ユーザー登録がされました"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.add_mail.subject
  #
  def add_mail(user, admin)
    @user = user
    @admin = admin

    mail to: user.email, bcc: admin.email, subject: "メールアドレスの登録/Todoアプリ"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.task_schedule.subject
  #
  def task_schedule(user, name, tasks)
    user = user
    @name = name
    @tasks = tasks

    mail to: user.email, subject: "通知メール/Todoアプリ"
  end
end
