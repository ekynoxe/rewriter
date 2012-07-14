class BookmarksController < ApplicationController
  before_filter :require_user
  
  def destroy
    bookmark = current_user.bookmarks.find_by_id(params[:id])
    if bookmark
      bookmark.destroy
      redirect_back_or_default(root_url)
    end
  end
end
