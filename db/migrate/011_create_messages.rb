class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.column :user_id,  :integer
      t.column :service_id,  :integer
      t.column :subject,  :string
      t.column :body,  :text
      t.column :created_at, :timestamp
      t.column :updated_at, :timestamp
    end
  end

  def self.down
    drop_table :messages
  end
end
