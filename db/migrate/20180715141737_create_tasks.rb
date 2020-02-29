class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.text :title
      t.integer :status, default: 0
      t.date :completion_date
      t.date :scheduled_date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
