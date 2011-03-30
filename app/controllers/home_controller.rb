class HomeController < ApplicationController
  before_filter :require_user
  
  def index
    @shared_url = SharedUrl.new
  end
end
