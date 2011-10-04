class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.string :title
#      t.string :company_name
#      t.string :company_info
#      t.string :company_website_url
      t.string :location
      t.text :description
      t.text :requirements
      t.text :contact_info
      t.integer :job_category_id
      t.integer :company_id

      t.timestamps
    end
  end

  def self.down
    drop_table :jobs
  end
end
