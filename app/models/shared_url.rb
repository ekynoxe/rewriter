class SharedUrl < ActiveRecord::Base
  validates_presence_of :full_url
end