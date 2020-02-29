class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:edit, :update, :show, :destroy]
  before_action :correct_user, only: [:show]
  before_action :admin_or_correct_user, only: [:edit, :update, :destroy]
  before_action :admin_user, only: [:index, :admin_edit]
  before_action :admin_user_destroy, only: :destroy

  def index
    @users = User.all
  end

  def show
    @all_task = current_user.tasks.task_count
    @complete_count = current_user.tasks.complete_count
    @aggregate_data = current_user.tasks.aggregate
    @complete_data = current_user.tasks.complete_aggregate
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ユーザーを登録しました。"
      redirect_to root_path
      @admin = User.find_by(admin: true)
      UserMailer.create_user(@user, @admin).deliver_later
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    @user = User.find_by(id: params[:id]) if current_user.admin?
    params_email = params[:user][:email]
    send_mail = false
    if @user.email != params_email && params_email != ""
      send_mail = true
    end
    if @user.update(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      @admin = User.find_by(admin: true)
      if send_mail
        flash[:info] = "登録したメールアドレスにメールを送信しました。<br>しばらく待っても届かない場合は、メールアドレスに誤りがないか、迷惑メールに入っていないか等をご確認ください。"
        UserMailer.add_mail(@user, @admin).deliver_now
      end
      if current_user.admin?
        redirect_to users_path
      else
        redirect_to user_path
      end
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find_by(id: params[:id]) if current_user.admin?
    @user.destroy
    flash[:success] = "ユーザーを削除しました。"
    if current_user.admin?
      redirect_to users_path
    else
      redirect_to root_path
    end
  end

  def admin_edit
    @user = User.find(params[:id])
  end

  private

    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation,
        :email, :avatar, :avatar_cache, :remove_avatar, :bgimage, :bgimage_cache, :remove_bgimage)
    end

    def set_user
      @user = current_user
    end

    # before_action

    # 正しいユーザーかどうか
    def correct_user
      @user = current_user
      redirect_to(root_url) unless current_user?(@user)
    end

    # 管理ユーザーもしくは正しいユーザーかどうか
    def admin_or_correct_user
      @user = current_user
      redirect_to(root_url) unless current_user.admin? || current_user?(@user)
    end

    def admin_user
      unless current_user.admin?
        flash[:danger] = "権限がありません"
        redirect_to(root_url)
      end
    end

    def admin_user_destroy
      id = params[:id]
      if id
        if !current_user.admin?
          flash[:danger] = "権限がありません"
          redirect_to(root_url)
        end
      end
    end

end
