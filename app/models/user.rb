class User < ActiveRecord::Base
  acts_as_authentic
  
  validates_presence_of   :login
  validates_uniqueness_of :login
  
  validates_presence_of   :email
  validates_uniqueness_of :email
  
  has_many :shared_urls, :through => :bookmarks
  has_many :bookmarks
  
  def isAdmin?
    return self.admin ? true : false
  end
end
