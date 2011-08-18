class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user_session, :current_user

  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end

    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to login_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to root_url
        return false
      end
    end
    
    def require_admin
      unless current_user && current_user.is_admin?
        store_location
        flash[:notice] = "You must be admin to access this page"
        redirect_to root_url
        return false
      end
    end

    def store_location
      session[:return_to] = request.fullpath
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

    def renderGroupOrHomeIndex
      @groups = current_user.groups
      @bookmarks = current_user.bookmarks.find(:all, :conditions => "group_id IS NULL", :order=>"bookmarks.created_at DESC")
      if params[:group_id].blank?
        render 'home/index'
      else
        @group = current_user.groups.find_by_id(params[:group_id])
        render 'groups/show'
      end
    end
end
