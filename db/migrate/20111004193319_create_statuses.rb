class CreateStatuses < ActiveRecord::Migration
  def self.up
    create_table :statuses do |t|
      t.integer :available
      t.integer :free_space
      t.string :name
      t.datetime :timestamp
      t.integer :station_id
      t.string :coordinates

      t.timestamps
    end
  end

  def self.down
    drop_table :statuses
  end
end
