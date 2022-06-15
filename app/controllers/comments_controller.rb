class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :comment_owner?, only: [:index]

  def index
    @comments = Comment.where(user: current_user)
    if params[:order].in? %w[new old]
      case params[:order]
      when 'new'
        @comments.order!(created_at: :desc)
      when 'old'
        @comments.order!(:created_at)
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @task = @comment.task

    if current_user == @comment.user || current_user == @comment.task.user
      @comment.destroy

      flash[:notice] = 'Comment Removed!'
    end

    redirect_to @task
  end

  private 
    
  def comment_owner?
    @profile = Profile.find(params[:profile_id])
    if !current_user
      redirect_to root_path
    elsif (current_user.profile != @profile and !@profile.share )
      redirect_to root_path
    end
  end
end

