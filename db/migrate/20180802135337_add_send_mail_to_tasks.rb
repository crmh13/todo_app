class AddSendMailToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :send_mail, :boolean, default: false
  end
end
