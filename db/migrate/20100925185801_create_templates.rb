class CreateTemplates < ActiveRecord::Migration
  def self.up
    create_table :templates do |t|
      t.references :site
      t.timestamps
    end
  end

  def self.down
    drop_table :templates
  end
end
