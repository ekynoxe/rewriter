class CreateUrlRequests < ActiveRecord::Migration
  def self.up
    create_table :url_requests do |t|
      t.references :shared_url
      
      t.timestamps
    end
  end

  def self.down
    drop_table :url_requests
  end
end
