class AddCoupleIdToUsers < ActiveRecord::Migration
  def self.up
	  add_column :users, :couple_id, :integer
  end

  def self.down
	  remove_column :users, :couple_id
  end
end
