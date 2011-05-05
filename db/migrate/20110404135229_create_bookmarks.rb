class CreateBookmarks < ActiveRecord::Migration
  def self.up
    create_table :bookmarks do |t|
      t.integer :user_id
      t.integer :shared_url_id

      t.timestamps
    end

    remove_column :shared_urls, :customer_id
  end

  def self.down
    drop_table :bookmarks
    
    add_column :shared_urls, :customer_id, :integer
  end
end
