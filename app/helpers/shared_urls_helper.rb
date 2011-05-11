module SharedUrlsHelper
  def format_shared_url_accessed(url)
    if url.url_requests.size == 0
      text = "never accessed"
    elsif url.url_requests.size == 1
      text = "accessed once"
    elsif url.url_requests.size == 2
      text = "accessed twice"
    else
      text = "accessed #{url.url_requests.size} times"
    end
    
    text
  end
end
