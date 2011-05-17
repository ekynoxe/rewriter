class Bookmark < ActiveRecord::Base
  belongs_to :user
  belongs_to :shared_url
  belongs_to :group
end
