class BookmarksController < ApplicationController
  before_filter :require_user
  
  def index
    @shared_url = SharedUrl.new
    @bookmarks = current_user.bookmarks.all
  end
  
  def destroy
    bookmark = current_user.bookmarks.find_by_id(params[:id])
    if bookmark
      bookmark.destroy
      redirect_to root_url
    end
  end
end
