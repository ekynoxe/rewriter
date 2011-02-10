class AddProtocolToUrl < ActiveRecord::Migration
  def self.up
    add_column :shared_urls, :protocol, :string, :default => 'http://'
  end

  def self.down
    remove_column :shared_urls, :protocol
  end
end
