class User < ActiveRecord::Base
  acts_as_authentic
  
  validates_presence_of   :full_name
  
  validates_presence_of   :login
  validates_uniqueness_of :login
  
  validates_presence_of   :email
  validates_uniqueness_of :email
  
  has_many :shared_urls,  :through => :bookmarks
  has_many :bookmarks,    :through => :groups
  has_many :bookmarks
  has_many :groups
  
  def is_admin?
    return self.admin ? true : false
  end
  
  def self.find_by_login_or_email(login)
    find_by_login(login) || find_by_email(login)
  end
  
  def email_address_with_name
    "#{self.login} <#{self.email}>"
  end
  
  def send_forgot_password!(domain)
    reset_perishable_token!
    Notifier.forgot_password(self,domain).deliver
  end
end
