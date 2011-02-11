class RemoveUriSchemeFromUrlDb < ActiveRecord::Migration
  def self.up
    remove_column :shared_urls, :protocol
  end
  
  def self.down
    add_column :shared_urls, :protocol, :string, :default => 'http://'
  end
end
