class ReferenceSiteFromDropboxFiles < ActiveRecord::Migration
  def self.up
    add_column :dropbox_files, :site_id, :integer

    DropboxFile.all.each do |i|
      i.site = i.dropbox_directory.site 
      i.save
    end
  end

  def self.down
    remove_column :dropbox_files, :site_id
  end
end
