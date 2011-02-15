class SharedUrlsController < ApplicationController
  USERNAME, PASSWORD = "the_admin", "46eec66813fa6e40f8eb683b5e9a0103" #Hint: it's the admin password!'
  before_filter :authenticate, :only => [:index]
  before_filter :prepareParams, :only => [:create]
  
  def index
    @shared_urls = SharedUrl.all
  end

  def new
    @shared_url = SharedUrl.new
  end
  
  def create
    @shared_url = SharedUrl.new(params[:shared_url])
    
    if !@shared_url.save
      render :new
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
    o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten;
    string  =  (0..l).map{ o[rand(o.length)]  }.join;
    
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
      uri = URI.parse(url)
      return uri.scheme + '://'+ uri.host + uri.request_uri
    rescue URI::InvalidURIError
      errors.add(:url, 'The format of the url is not valid.')
    end
  end
  
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == USERNAME && Digest::MD5.hexdigest(password) == PASSWORD
    end
  end
end
