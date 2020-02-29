class TasksController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  def show
    @task = current_user.tasks.find_by(id: params[:id])
    @details_count = @task.details
    @details = @task.details.search(
      params[:complete], params[:search], params[:not_work], params[:working]).
      page(params[:page])
    @detail = @task.details.build
    @comments = @task.comments
    @comment = @task.comments.build
    @not_work_data = @details_count.where(status: 0).count
    @working_data = @details_count.where(status: 1).count
    @complete_data = @details_count.where(status: 2).count
    @chart_data = [['未作業', @not_work_data], ['作業中', @working_data], ['完了', @complete_data]]
    @complete_check = params[:complete]
    @not_work_check = params[:not_work]
    @working_check = params[:working]
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = "タスクを登録しました"
      redirect_to task_path(@task)
    else
      render 'new'
    end
  end

  def edit
    @task = current_user.tasks.find_by(id: params[:id])
  end

  def update
    @task = current_user.tasks.find_by(id: params[:id])
    if @task.update(task_params)
      flash[:success] = "タスク情報を更新しました。"
      redirect_to task_path(@task)
    else
      render 'edit'
    end
  end

  def destroy
    current_user.tasks.find_by(id: params[:id]).destroy
    flash[:success] = "タスクを削除しました"
    redirect_to root_path
  end

  def complete
    @tasks = current_user.tasks.complete_search(
        params[:over], params[:no_schedule], params[:search]).page(params[:page])
    @limit_over =  current_user.tasks.where(["scheduled_date < completion_date"]).count
    @date_before = current_user.tasks.where(["scheduled_date > completion_date"]).count
    @scheduled = current_user.tasks.where(["scheduled_date = completion_date"]).count
    @chart_data = [['予定日完了', @scheduled], ['予定前完了', @date_before], ['予定超過', @limit_over]]
    @limit_check = params[:no_schedule]
    @over_check = params[:over]
  end

  private

    def task_params
      params.require(:task).permit(:title, :status, :completion_date, :scheduled_date, :send_mail)
    end

    def correct_user
      @task = current_user.tasks.find_by(id: params[:id])
      redirect_to root_url if @task.nil?
    end
end
