class DropboxFile < ActiveRecord::Base
  belongs_to :site
  belongs_to :dropbox_directory
  belongs_to :item, :polymorphic => true, :autosave => true

  validates_presence_of :site 

  attr_readonly :path
  validates_presence_of :path
  validates_format_of   :path, :with => /^\//, :message => "should be absolute"

  validates_presence_of :modified
  
  before_save do
    if text_file? and (new_record? or modified_changed?)
      self.contents = site.dropbox.download(path)
    end
  end
  
  before_save(:on => :create) do
    if item.nil?
      if path =~ /^Site\/blog\//
        self.item = Post.new(:site => site, :dropbox_file => self)
      end
    end
  end
  
  after_save(:on => :create) do
    if item and item.changed?
      item.save
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
  
  def contents
    return read_attribute(:contents) if text_file?
    return @contents_cache if @contents_cache
    logger.info "  DropboxFile #{id} loading contents from Dropbox. [THIS MIGHT BE SLOW]"
    @contents_cache ||= site.dropbox.download(path)
  end
  
end
