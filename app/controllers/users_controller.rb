class UsersController < ApplicationController
  before_filter :require_admin, :except => [:new,:create]
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
end
