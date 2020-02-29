class AddIndexToTask < ActiveRecord::Migration[5.2]
  def change
    add_index :tasks, :scheduled_date
  end
end
