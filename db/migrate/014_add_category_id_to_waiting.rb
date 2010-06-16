class AddCategoryIdToWaiting < ActiveRecord::Migration
  def self.up
    add_column :waiting_lists, :category_id, :integer
  end

  def self.down
    remove_column :waiting_lists, :category_id
  end
end
