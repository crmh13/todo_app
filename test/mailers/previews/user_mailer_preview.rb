# Preview all emails at http://192.168.33.11:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://192.168.33.11:3000/rails/mailers/user_mailer/create_user
  def create_user
    user = User.find(2)
    admin = User.find_by(admin: true)
    UserMailer.create_user(user, admin)
  end

  # Preview this email at http://192.168.33.11:3000/rails/mailers/user_mailer/add_mail
  def add_mail
    user = User.find(2)
    admin = User.find_by(admin: true)
    UserMailer.add_mail(user, admin)
  end

  # Preview this email at http://192.168.33.11:3000/rails/mailers/user_mailer/task_schedule
  def task_schedule
    user = User.find(2)
    name = user.name
    tasks = user.tasks.where(scheduled_date: Date.today).where.not(status: 2).where(send_mail: true)
    UserMailer.task_schedule(user, name, tasks)
  end

end
