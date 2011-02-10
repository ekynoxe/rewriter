class CreateSharedUrls < ActiveRecord::Migration
  def self.up
    create_table :shared_urls do |t|
      t.integer :customer_id
      t.string  :full_url
      t.string  :short_url
      t.string  :title

      t.timestamps
    end
  end

  def self.down
    drop_table :shared_urls
  end
end
