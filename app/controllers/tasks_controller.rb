class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks = Task.order(created_at: :desc).page(params[:page]).per(3)
  end
  
  def show
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    
    if @task.save
      flash[:success] = '新しいタスクが追加されました。'
      redirect_to @task
    else
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
  
end
