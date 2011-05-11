class Admin::SharedUrlsController < ApplicationController
  before_filter :require_admin
  layout 'admin'
  
  def index
    @shared_urls = SharedUrl.all
    @shared_urls.sort! {|x,y| x.created_at <=> y.created_at }
  end
end
