class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :name
      t.text :info
      t.string :website_url

      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
