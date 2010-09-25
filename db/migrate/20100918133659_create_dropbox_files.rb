class CreateDropboxFiles < ActiveRecord::Migration
  def self.up
    create_table :dropbox_files do |t|
      t.string :path
      t.integer :size
      t.text :contents
      t.references :dropbox_directory
      t.timestamps
    end
  end

  def self.down
    drop_table :dropbox_files
  end
end
