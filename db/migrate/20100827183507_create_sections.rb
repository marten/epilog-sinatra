class CreateSections < ActiveRecord::Migration
  def self.up
    create_table :sections do |t|
      t.string :title
      t.string :slug
      
      t.references :site
      
      t.timestamps
    end
  end

  def self.down
    drop_table :sections
  end
end
