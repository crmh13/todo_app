class CommentsController < ApplicationController
  before_action :logged_in_user, only:[:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @task = current_user.tasks.find_by(id: params[:task_id])
    @comments = @task.comments
    @comment_post = @task.comments.build(comment_params)
    @comment_post.save
    respond_to do |format|
      format.html { redirect_to task_path(@task) }
      format.js
    end
    #redirect_to task_path(@task)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @task = Task.find_by(id: @comment.task_id)
    @comments = @task.comments
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to task_path(@task) }
      format.js
    end
    #redirect_to task_path(@task)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def correct_user
    @comment = Comment.find(params[:id])
    @task = Task.find_by(id: @comment.task_id)
    redirect_to root_url if current_user.id != @task.user_id
  end
end
