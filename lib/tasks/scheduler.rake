desc "This task is called by the Heroku scheduler add-on"
task :test_scheduler => :environment do
  User.where.not(email: nil).find_each do |user|
    tasks = user.tasks.where(scheduled_date: Date.today).where.not(status: 2).where(send_mail: true)
    if tasks.any?
      puts user.name
      tasks.each do |task|
        puts task.title
      end
    end
  end
end

task :send_mail => :environment do
  User.where.not(email: nil).find_each do |user|
    @name = user.name
    @tasks = user.tasks.where(scheduled_date: Date.today).where.not(status: 2).where(send_mail: true)
    if @tasks.any?
      UserMailer.task_schedule(user, @name, @tasks).deliver_now
    end
  end
end