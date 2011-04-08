class SharedUrlsController < ApplicationController
  before_filter :require_admin, :only => [:index]
  before_filter :require_user, :except => [:show]
  before_filter :prepareParams, :only => [:create]
  
  def index
    @shared_urls = SharedUrl.all
  end

  def new
    @shared_url = SharedUrl.new
  end
  
  def create
    if !@shared_url = SharedUrl.find_by_full_url(params[:shared_url][:full_url])
      @shared_url = SharedUrl.new(params[:shared_url])
      if !@shared_url.save
        flash[:item_notice]='could not save your shared url'
        render :new
      end
    end
    
    # url has already been shared, but do we have a bookmark for it?
    if !@bookmark = current_user.bookmarks.find_by_shared_url_id(@shared_url.id)
      @bookmark=current_user.bookmarks.build(:shared_url => @shared_url)
      if !@bookmark.save
        flash[:item_notice]='could not save your bookmark'
        render :new
      end
    end
  end
  
  def show
    @shared_url = SharedUrl.find_by_short_url(params[:id])
    
    if !@shared_url
      redirect_to root_url
    else
      redirect_to @shared_url.full_url
    end
  end
  
  private
  def prepareParams
      parameters = params[:shared_url]
      
      parameters[:short_url] = prepareShortUrl
      parameters[:full_url] = prepareFullUrl(parameters[:full_url])
      
      params[:shared_url] = parameters
  end
  
  def prepareShortUrl(l=0)
    o =  [('a'..'z'),('A'..'Z'),('0'..'9')].map{|i| i.to_a}.flatten;
    string  =  (0..l).map{ o[rand(o.length)]  }.join;
    
    # Here it might be useful to prevent short urls to be one 
    # => of the named routes names like "login", "logout", "register", "users"...
    
    if SharedUrl.find_by_short_url(string)
      return prepareShortUrl(l+1)
    else
      return string
    end
  end
  
  def prepareFullUrl(url)
    if url.blank?
      return nil
    end
    
    begin
      uri = URI.split(url)
      
      scheme  = uri[0].blank? ? 'http' : uri[0]
      host    = uri[2].blank? ? '' : uri[2]
      path    = uri[5].blank? ? '' : uri[5]
      
      return scheme + '://'+ host + path
    rescue URI::InvalidURIError
      errors.add(:url, 'The format of the url is not valid.')
    end
  end
end
