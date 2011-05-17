class BookmarksController < ApplicationController
  before_filter :require_user
  
  def index
    redirect_to root_url
  end
  
  def destroy
    bookmark = current_user.bookmarks.find_by_id(params[:id])
    if bookmark
      bookmark.destroy
      redirect_to root_url
    end
  end
end
