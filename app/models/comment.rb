class Comment < ApplicationRecord
  belongs_to :task
  validates :body, presence: true
  validates :task_id, presence: true
end
