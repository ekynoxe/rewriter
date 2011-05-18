class Group < ActiveRecord::Base
  belongs_to :user
  has_many :bookmarks
  
  validates_uniqueness_of :name, :scope => [:user_id]
end
