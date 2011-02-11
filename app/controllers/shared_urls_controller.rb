class SharedUrlsController < ApplicationController
  before_filter :prepareParams, :only => [:create]
  
  def index
    # redirect to Home for prod so we don't list all urls
#    redirect_to root_url
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
    begin
      uri = URI.parse(url)
      return uri.scheme + '://'+ uri.host + uri.request_uri
    rescue URI::InvalidURIError
      errors.add(:url, 'The format of the url is not valid.')
    end
  end
end
