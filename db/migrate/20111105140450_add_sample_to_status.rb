class AddSampleToStatus < ActiveRecord::Migration
  def self.up
    add_column :statuses, :sample_id, :integer
  end

  def self.down
  remove_column :statuses, :sample_id
  end
end
