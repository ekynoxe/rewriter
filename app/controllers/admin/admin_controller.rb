class Admin::AdminController < ApplicationController
  before_filter :require_admin
  layout 'admin'
  
  def index
  end
  
  def update
    GlobalSettings.admin_email = params[:admin_email] if params[:admin_email]
    
    redirect_to admin_url
  end
end
