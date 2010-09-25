class DropboxFile < ActiveRecord::Base
  belongs_to :dropbox_directory
  before_save do
    if text_file? and (new_record? or date_changed?)
      self.contents = dropbox_directory.site.dropbox.download(path)
    end
  end
  
  def text_file?
    # FIXME This is a really simple check, we need to do better than that. MIME::Types perhaps?
    path =~ /\.(txt|markdown|textile|html|css)$/
  end
end
