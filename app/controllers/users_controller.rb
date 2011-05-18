class UsersController < ApplicationController
  before_filter :require_admin, :only => [:index]
  before_filter :require_user, :only => [:change_password,:update]
  rescue_from AbstractController::ActionNotFound, :with => :redirect_home
  rescue_from ActionController::UnknownAction, :with => :redirect_home
  rescue_from ActiveRecord::RecordNotFound, :with => :redirect_home
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if !@user.save
      flash[:item_notice]='could not register'
      render :new
      return
    end
    redirect_to root_url
  end
  
  def change_password
  end
  
  def change_details
  end
  
  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to root_url
    else
      case
      when !params[:user][:password].blank? && !params[:user][:password_confirmation].blank?
        render :action => :change_password
      when !params[:user][:email].blank?
        render :action => :change_details
      else
        render :action => :change_password
      end
    end
  end
  
  def reset_password
    @user = User.find_using_perishable_token(params[:reset_password_code], 1.week) || (raise ActiveRecord::RecordNotFound)
  end

  def reset_password_submit
    @user = User.find_using_perishable_token(params[:reset_password_code], 1.week) || (raise ActiveRecord::RecordNotFound)
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully reset password."
      redirect_to root_url
    else
      flash[:notice] = "There was a problem resetting your password."
      render :action => :reset_password
    end
  end
  
  private
  def redirect_home exception
    redirect_to root_url
  end
end
