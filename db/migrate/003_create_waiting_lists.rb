class CreateWaitingLists < ActiveRecord::Migration
  def self.up
    create_table :waiting_lists do |t|
      t.column :client_id,  :integer
      t.column :service_id,  :integer
      t.column :referral_date,  :timestamp
      t.column :accepted_date,  :timestamp
      t.column :completed_date,  :timestamp
      t.column :created_at, :timestamp
      t.column :updated_at, :timestamp
    end
  end

  def self.down
    drop_table :waiting_lists
  end 
end
