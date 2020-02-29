class CreateDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :details do |t|
      t.text :content
      t.integer :status, default: 0
      t.references :task, foreign_key: true

      t.timestamps
    end
  end
end
