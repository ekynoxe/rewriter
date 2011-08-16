class GroupsController < ApplicationController
  before_filter :require_user
  before_filter :store_location, :only=>[:show]
  
  def index
    redirect_to root_url
  end
  
  def show
    @groups = current_user.groups.all
    @group = current_user.groups.find_by_id(params[:id]) or redirect_to root_url
    @bookmark = Bookmark.new
    @new_group = Group.new
    @shared_url = SharedUrl.new
  end
  
  def new
    @shared_url = SharedUrl.new
    @new_group = Group.new
  end
  
  def create
    @new_group = current_user.groups.create(params[:group])
    if !@new_group.save
      flash[:item_notice]='could not save your group'
      render :new and return
    end
    redirect_to root_url
  end
  
  def update
  end

  def destroy
    group = current_user.groups.find_by_id(params[:id])
    if group
      group.bookmarks.update_all("group_id = NULL")
      group.destroy
      redirect_to root_url
    end
  end

  def add_bookmarks
    if params[:group].blank? || params[:bookmarks].blank?
    # if we don't have a group or bookmarks, then do nothing  
      redirect_back_or_default(root_url)
      
    elsif params[:group][:id].blank? && params[:bookmarks]
    # if we don't have a group but bookmarks are set, we need to move bookmarks out of their current group
      params[:bookmarks].each do |bookmark_id|
        if b = Bookmark.find(bookmark_id)
          b.update_attributes(:group_id => nil)
        end
      end
      redirect_back_or_default(root_url)
      
    else
    # else move the bookmarks to the requested group if found
      if group = current_user.groups.find_by_id(params[:group][:id])
        params[:bookmarks].each do |bookmark_id|
          if b = Bookmark.find(bookmark_id)
            b.update_attributes(:group_id => group.id)
          end
        end
      end
      redirect_back_or_default(root_url)
    end
  end
end
