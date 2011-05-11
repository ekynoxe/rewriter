class SharedUrl < ActiveRecord::Base
  validates_presence_of :full_url
  
  has_many :users, :through => :bookmarks
  has_many :bookmarks
  
  has_many :url_requests
end