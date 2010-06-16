class CreateTodos < ActiveRecord::Migration
  def self.up
    create_table :todos do |t|
      t.string :title
      t.text :body
      t.boolean :done
      t.datetime :due

      t.timestamps
    end
  end

  def self.down
    drop_table :todos
  end
end
