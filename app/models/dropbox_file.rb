class DropboxFile < ActiveRecord::Base
  belongs_to :dropbox_directory
  
  belongs_to :item, :polymorphic => true
  
  before_save do
    if text_file? and (new_record? or date_changed?)
      self.contents = dropbox_directory.site.dropbox.download(path)
    end
  end
  
  after_save(:on => :create) do
    # TODO figure out what type of item to make, and make it
    if path =~ /^\/Site\/blog\//
      Post.create(:site => dropbox_directory.site, :dropbox_file => self)
    end
  end
  
  after_save(:on => :update) do
    if item and item.respond_to?(:process_dropbox_file_update)
      item.process_dropbox_file_update(self)
    end
  end
  
  def text_file?
    # FIXME This is a really simple check, we need to do better than that. MIME::Types perhaps?
    path =~ /\.(txt|markdown|textile|html|css)$/
  end
  
end
