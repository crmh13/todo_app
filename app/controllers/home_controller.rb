class HomeController < ApplicationController
  def index
    if logged_in?
      @tasks = current_user.tasks.search(
        params[:complete], params[:search], params[:no_schedule], params[:working]).page(params[:page])
      @complete_count = current_user.tasks.where(status: 2).count
      @limit_over_task = current_user.tasks.where(["scheduled_date < ?", Date.today])
        .where.not(status: 2).count
      @not_work_task = current_user.tasks.where(status: 0).count
      @working_task = current_user.tasks.where(status: 1).count
      @chart_data = [['未作業', @not_work_task], ['作業中', @working_task], ['完了', @complete_count]]
      @complete_check = params[:complete]
      @limit_check = params[:no_schedule]
      @working_check = params[:working]
    end
  end

  def about
  end
end
