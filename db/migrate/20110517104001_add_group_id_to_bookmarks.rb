class AddGroupIdToBookmarks < ActiveRecord::Migration
  def self.up
    add_column :bookmarks, :group_id, :integer
  end

  def self.down
    remove_column :bookmarks, :group_id
  end
end
