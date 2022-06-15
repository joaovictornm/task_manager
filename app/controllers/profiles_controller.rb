class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_profile, only: [:show, :edit, :update, :change_privacy, :private_page]
  before_action :public?, except: [:new, :private_page]
 
  def show 
  end

  def new
    if current_user.profile
      redirect_to current_user.profile
    end

    @profile = Profile.new
  end

  def create 
    @profile = Profile.create(profile_params)
    @profile.user = current_user

    if @profile.save
      flash[:notice] = 'Profile Created!'
      redirect_to @profile
    else
      render :new
    end
  end

  def edit 
    if current_user.profile != @profile
      redirect_to @profile
    end
  end

  def update
    if current_user.profile == @profile && @profile.update(profile_params)
      flash[:notice] = 'Profile Updated!'
      redirect_to @profile
    else
      render :edit
    end 
  end

  def change_privacy
    if current_user.profile == @profile && privacy_params[:share] != @profile.share.to_s && @profile.update(privacy_params)
      flash[:notice] = 'Privacy Updated!'
    end
    redirect_to @profile
  end

  def private_page 
    if current_user.profile == @profile || @profile.share
      redirect_to @profile
    end
  end

  private 

  def profile_params
    params.require(:profile).permit(:nickname, :bio, :avatar)
  end 

  def privacy_params
    params.require(:profile).permit(:share)
  end

  def find_profile
    @profile = Profile.find(params[:id])
  end

  def public?
    if current_user.profile != @profile && @profile.share.blank?
      redirect_to private_page_profile_path(@profile)
    end
  end
end
  
