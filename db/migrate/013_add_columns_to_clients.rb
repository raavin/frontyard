class AddColumnsToClients < ActiveRecord::Migration
  def self.up
    add_column :clients, :post_code, :string
    add_column :clients, :gender_string, :string
    add_column :clients, :country_string, :string
  end

  def self.down
    remove_column :clients, :post_code
    remove_column :clients, :gender_string
    remove_column :clients, :country_string
  end
end
