class AddAdminFlagToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :admin, :boolean, :default => false
  end

  def self.down
    add_column :users, :admin
  end
end
