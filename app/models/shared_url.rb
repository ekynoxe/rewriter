class SharedUrl < ActiveRecord::Base
  after_save :shorten
  
  validates_presence_of :customer_id
  validates_presence_of :full_url
  validates_presence_of :title
  
  private
  
  def shorten
    
    self.short_url = encode(self.id)
  end
  
  CHARS = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".split('')
  BASE = 62

  def encode(value)
    s = []
    
    while value >= BASE
      value, rem = value.divmod(BASE)
      s << CHARS[rem]
    end
    
    s << CHARS[value]
    s.reverse.to_s
  end

  def decode(str)
    str = str.split('').reverse
    total = 0
    str.each_with_index do |v,k|
      total += (CHARS.index(v) * (BASE ** k))
    end
    total
  end
end