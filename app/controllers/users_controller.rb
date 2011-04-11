class UsersController < ApplicationController
  before_filter :require_admin, :except => [:new,:create]
  before_filter :require_user, :only => [:change_password,:update]
  rescue_from AbstractController::ActionNotFound, :with => :redirect_home
  rescue_from ActionController::UnknownAction, :with => :redirect_home
  
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
    render
  end
  
  def update
    logger.debug '### '+params[:user].inspect
    if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
      flash[:notice] = '<p class="notice">Please fill in the password fields</p>'.html_safe
      redirect_to change_password_url
    else
      current_user.password = params[:user][:password]
      current_user.password_confirmation = params[:user][:password_confirmation]
    
      if current_user.save
        flash[:notice] = '<p class="notice">Password successfully updated</p>'.html_safe
        redirect_to root_url
      else
        flash[:notice] = '<p class="notice">There has been a problem saving your new password, Please try again later</p>'.html_safe
        redirect_to change_password_url
      end
    end
  end
  
  private
  def redirect_home exception
    redirect_to root_url
  end
end
