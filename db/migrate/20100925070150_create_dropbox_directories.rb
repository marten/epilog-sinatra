class CreateDropboxDirectories < ActiveRecord::Migration
  def self.up
    create_table :dropbox_directories do |t|
      t.string :path
      t.string :hash
      t.references :site
      t.timestamps
    end
  end

  def self.down
    drop_table :dropbox_directories
  end
end
