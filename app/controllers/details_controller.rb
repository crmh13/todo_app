class DetailsController < ApplicationController
  before_action :logged_in_user, only:[:create, :update, :destroy]
  before_action :correct_user, only:[:update, :destroy]
  before_action :setup_details, only:[:update, :destroy]

  def create
    @task = current_user.tasks.find_by(id: params[:task_id])
    @details = @task.details
    @detail_post = @task.details.build(detail_params)
    @detail_post.save
    status_change
    redirect_to task_path(@task)
  end

  def update
    @task = Task.find_by(id: @detail.task_id)
    @detail = Detail.find(params[:id])
    @detail.update(detail_params)
    status_change
    redirect_to task_path(@task)
  end

  def destroy
    @detail = Detail.find(params[:id])
    @task = Task.find_by(id: @detail.task_id)
    @detail.destroy
    status_change
    redirect_to task_path(@task)
  end

  private

    def detail_params
      params.require(:detail).permit(:content, :status, :completion_date)
    end

    def correct_user
      @detail = Detail.find(params[:id])
      @task = Task.find_by(id: @detail.task_id)
      redirect_to root_url if current_user.id != @task.user_id
    end

    def setup_details
      @details = @task.details
    end

    def status_change
      if @details.count == 0
        @task.update(status: 0, completion_date: nil)
      elsif @details.count == @details.where(status: 2).count
        @task.update(status: 2, completion_date: Date.today)
      elsif @details.where.not(status: 0).count > 0
        @task.update(status: 1, completion_date: nil)
      else
        @task.update(status: 0, completion_date: nil)
      end
    end

end
