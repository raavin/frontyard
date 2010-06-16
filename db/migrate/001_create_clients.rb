class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.column :first_name, :string
      t.column :last_name,  :string
      t.column :dob,        :date
      t.column :country_id, :integer
      t.column :gender,     :integer
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end
  def self.down
    drop_table :clients
  end
end
