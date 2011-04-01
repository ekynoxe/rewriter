class User < ActiveRecord::Base
  acts_as_authentic
  
  #add validators
  #add has_many shared_urls
  
  def isAdmin?
    return self.admin ? true : false
  end
end
