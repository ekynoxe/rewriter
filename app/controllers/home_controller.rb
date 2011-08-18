class HomeController < ApplicationController
  before_filter :require_user
  before_filter :store_location, :only=>[:index]
  
  def index
    @shared_url = SharedUrl.new
    @bookmark = Bookmark.new
    @bookmarks = current_user.bookmarks.find(:all, :conditions => "group_id IS NULL", :order=>"bookmarks.created_at DESC")
    
    @groups = current_user.groups.all
    @new_group = Group.new
  end
end
