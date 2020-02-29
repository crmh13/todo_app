class Task < ApplicationRecord
  belongs_to :user, counter_cache: true
  has_many :details, dependent: :destroy
  has_many :comments, dependent: :destroy
  default_scope -> { order(:scheduled_date) }
  validates :user_id, presence: true
  validates :title, presence: true

  def self.search(complete, search, no_schedule, working)
    result = Task.all
    result = result.where.not(status: 2).all if complete.nil?
    result = result.where('title LIKE ?', "%#{search}%").all if search
    result = result.where.not(scheduled_date: nil).all if no_schedule
    result = result.where(status: 1).all if working
    result
  end

  def self.complete_search(over, no_schedule, search)
    result = Task.where(status: 2).reorder(completion_date: :desc).all
    result = result.where(["scheduled_date < completion_date"]).all if over
    result = result.where.not(scheduled_date: nil).all if no_schedule
    result = result.where('title LIKE ?', "%#{search}%").all if search
    result
  end

  def self.aggregate
    today = Date.today
    day = today.prev_month
    day_data = {}
    while day <= today do
      day_data.store(day, Task.where("Date(created_at) <= ?", day).count)
      day += 1
    end
    day_data
  end

  def self.complete_aggregate
    today = Date.today
    day = today.prev_month
    day_data = {}
    while day <= today do
      day_data.store(day, Task.where("Date(completion_date) <= ?", day).count)
      day += 1
    end
    day_data
  end

  def self.task_count
    Task.where(created_at: Time.zone.now.ago(1.month)..Time.zone.now).count
  end

  def self.complete_count
    Task.where(completion_date: Time.zone.now.ago(1.month)..Time.zone.now).count
  end

end
