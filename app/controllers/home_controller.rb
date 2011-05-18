class HomeController < ApplicationController
  before_filter :require_user
  
  def index
    @shared_url = SharedUrl.new
    @bookmarks = current_user.bookmarks.find(:all, :conditions => "group_id IS NULL")
    
    @groups = current_user.groups.all
    @new_group = Group.new
  end
end
