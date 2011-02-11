class HomeController < ApplicationController
  def index
    @shared_url = SharedUrl.new
  end
end
