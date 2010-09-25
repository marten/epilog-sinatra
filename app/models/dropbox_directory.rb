class DropboxDirectory < ActiveRecord::Base
  belongs_to :site
  has_many :dropbox_files

  attr_readonly :path
  validates_format_of :path, :with => /^\//, :message => "should be absolute"
  
  def metadata
    @metadata ||= site.dropbox.metadata(path)
  end
  
  def fresh?
    version_hash and version_hash == metadata.hash
  end
  
  def synchronize
    return if fresh?
    synchronize!
  end
  
  def synchronize!
    print "Synchronizing #{path}... "
    
    remote_files = metadata.contents.sort_by(&:path)
    local_files  = dropbox_files.all.sort_by(&:path)
    
    to_create = []
    to_update = []
    to_delete = []
    
    remote_index = 0
    local_index  = 0
    
    while remote_index <= remote_files.size and local_index <= local_files.size
      remote = remote_files[remote_index]
      local  = local_files[local_index]
      
      break unless remote or local
      
      # Remote is less than local, or we've processed all locals, so add remote.
      if remote and ((not local) or (remote.path < local.path))
        to_create << remote
        remote_index += 1
        next
      end
      
      # Local is less than remote, or we've processed all remotes, so delete local
      if local and ((not remote) or (remote.path > local.path))
        to_delete << local
        local_index += 1
        next
      end
  
      # Remote and local are at the same file. We might need to update
      if remote.path == local.path
        to_update << {:remote => remote, :local => local} if remote.modified < local.modified
        remote_index += 1
        local_index  += 1
        next
      else
        raise "Should not happen"
      end
    end

    to_create.each {|i| print 'A'; dropbox_files.create(:path => i.path, :modified => i.modified, :size => i.bytes) }
    to_update.each {|i| print 'U'; i[:local].update_attributes(:modified => i[:remote].modified, :size => i[:remote].bytes)}
    to_delete.each {|i| print 'D'; i.destroy }
    
    update_attribute(:version_hash, metadata.hash)
    
    puts " ... done"
  end
end
