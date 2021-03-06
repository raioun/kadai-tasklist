class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
    if logged_in?
      @task = current_user.tasks.build #form_for用
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page]).per(3)
      # @tasks = Task.order(created_at: :desc).page(params[:page]).per(3)
    end
  end
  
  def show
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = '新しいタスクが追加されました。'
      redirect_to @task
    else
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'タスクが追加されませんでした。'
      render :new
    end
  end
  
  def edit
  end
  
  def update
    # binding.pry
    
    if @task.update(task_params)
      flash[:success] = 'このタスクは更新されました。'
      redirect_to @task
    else
      flash.now[:danger] = 'このタスクは更新されませんでした。'
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    
    flash[:success] = '先ほどのタスクが削除されました。'
    redirect_to tasks_url
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  #Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
  
end
