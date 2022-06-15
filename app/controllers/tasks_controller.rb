class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :user_profile?
  before_action :find_task, only: %i[show edit update destroy change_status create_comment]
    
  def index
    case params[:order]
      when 'id_asc'
        @tasks = Task.where(share: true).order(id: :asc)
      when 'id_desc'
        @tasks = Task.where(share: true).order(id: :desc)
      when 'title_asc'
        @tasks = Task.where(share: true).order(title: :asc)
      when 'title_desc'
        @tasks = Task.where(share: true).order(title: :desc)
      when 'description_asc'
        @tasks = Task.where(share: true).order(description: :asc)
      when 'description_desc'
        @tasks = Task.where(share: true).order(description: :desc)
      when 'priority_asc'
        @tasks = Task.where(share: true).order(priority: :asc)
      when 'priority_desc'
        @tasks = Task.where(share: true).order(priority: :desc)
      when 'status_asc'
        @tasks = Task.where(share: true).order(status: :asc)
      when 'status_desc'
        @tasks = Task.where(share: true).order(status: :desc)
      when 'email_asc'
        @tasks = Task.where(share: true).includes(:user).order('users.email')
      when 'email_desc'
        @tasks = Task.where(share: true).includes(:user).order('users.email').reverse_order
      else
        @tasks = Task.where(share: true)
    end
  end

  def show
    redirect_to tasks_path if @task.nil?

    @comment = Comment.new
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
    @task.user = current_user

    if @task.save
      flash[:notice] = 'Task Created!'
      redirect_to @task
    else
      flash[:notice] = @task.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    if current_user != @task.user
      redirect_to @task
    end
  end

  def update
    if current_user == @task.user
      if @task.update(task_params)
        flash[:notice] = 'Task Updated!'
        redirect_to @task
      else
        flash[:notice] = @task.errors.full_messages.to_sentence
        render :edit
      end
    else
      redirect_to @task
    end 
  end

  def destroy
    @task = Task.find(params[:id])

    if current_user == @task.user
      @task.destroy

      flash[:notice] = 'Task Removed!'
    end

    redirect_to tasks_path
  end

  def change_status
    if current_user == @task.user && status_params[:status] != @task.status.to_s && @task.update(status_params)
      flash[:notice] = 'Status Updated!'
    end

    redirect_to @task
  end

  def create_comment
    @comment = Comment.create(comment_params)
    @comment.task = Task.find(params[:id])
    @comment.user = current_user

    if @comment.save
      flash[:notice] = 'Comment Created!'
    else
      flash[:notice] = @comment.errors.full_messages.to_sentence
    end

    redirect_to @task
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :priority, :status, :share)
  end

  def status_params
    params.require(:task).permit(:status)
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_task
    @task = Task.where("user_id = ? OR share = ?", current_user.id, true).find_by(id: params[:id])
  end
end

