class Detail < ApplicationRecord
  belongs_to :task
  default_scope -> { order(:created_at) }
  validates :content, presence: true
  validates :task_id, presence: true

  def self.search(complete, search, not_work, working)
    result = Detail.all
    result = result.where.not(status: 2).all if complete
    result = result.where('content LIKE ?', "%#{search}%").all if search
    result = result.where.not(status: 0).all if not_work
    result = result.where.not(status: 1).all if working
    result
  end
end
