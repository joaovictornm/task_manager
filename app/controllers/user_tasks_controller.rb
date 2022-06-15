class UserTasksController < ApplicationController
  before_action :authenticate_user!

  def index
    case params[:order]
      when 'id_asc'
        @tasks = current_user.tasks.order(id: :asc)
      when 'id_desc'
        @tasks = current_user.tasks.order(id: :desc)
      when 'title_asc'
        @tasks = current_user.tasks.order(title: :asc)
      when 'title_desc'
        @tasks = current_user.tasks.order(title: :desc)
      when 'description_asc'
        @tasks = current_user.tasks.order(description: :asc)
      when 'description_desc'
        @tasks = current_user.tasks.order(description: :desc)
      when 'priority_asc'
        @tasks = current_user.tasks.order(priority: :asc)
      when 'priority_desc'
        @tasks = current_user.tasks.order(priority: :desc)
      when 'status_asc'
        @tasks = current_user.tasks.order(status: :asc)
      when 'status_desc'
        @tasks = current_user.tasks.order(status: :desc)
      else
        @tasks = current_user.tasks
    end
  end

  def task_report
    @comments = Comment.includes(:task).where({ tasks: { user: current_user, status: 'complete' }}).order(body: :asc)
  end
end