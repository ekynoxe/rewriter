class GroupsController < ApplicationController
  before_filter :require_user
  
  def index
    redirect_to root_url
  end
  
  def show
    @groups = current_user.groups.all
    @group = current_user.groups.find_by_id(params[:id]) or redirect_to root_url
  end
  
  def new
    @shared_url = SharedUrl.new
  end
  
  def create
    @group = current_user.groups.create(params[:group])
    if !@group.save
      flash[:item_notice]='could not save your group'
      render :new and return
    end
    redirect_to root_url
  end
  
  def update
  end
=begin
  def destroy
    group = current_user.groups.find_by_id(params[:id])
    if group
      
      group.destroy
      redirect_to root_url
    end
  end
=end
  def add_bookmark
  end
end
