class CreateServices < ActiveRecord::Migration
  def self.up
    create_table :services do |t|
      t.column :service_name,  :string
      t.column :description,  :text
      t.column :min_age,  :integer
      t.column :max_age,  :integer
      t.column :created_at, :timestamp
      t.column :updated_at, :timestamp
    end
  end
  def self.down
    drop_table :services
  end
end
