class DropboxDirectory < ActiveRecord::Base
  belongs_to :site
  has_many :dropbox_files
  
  def metadata
    @metadata ||= site.dropbox.metadata(path)
  end
  
  def fresh?
    version_hash and version_hash == metadata.hash
  end
  
  def synchronize
    return if fresh?
    
    print "Synchronizing #{path}... "
    
    remote_files = metadata.contents.sort_by(&:path)
    local_files  = dropbox_files.all.sort_by(&:path)
    
    puts '-----------------------'
    puts remote_files.inspect
    puts local_files.inspect
    puts '-----------------------'
    
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
        # TODO, need to know what method to call on remote for this
        # if not remote.date == local.date
        #   to_update << {:remote => remote, :local => local}
        # end
      end
    end

    puts to_create.inspect
    puts to_update.inspect
    puts to_delete.inspect
    
    to_create.each {|i| print 'A'; dropbox_files.create(:path => i.path, :date => i.modified, :size => i.bytes) }
    to_update.each {|i| print 'U'; i[:local].update_attributes(:date => i[:remote].modified, :size => i[:remote].bytes)}
    to_delete.each {|i| print 'D'; i.destroy }
    
    update_attribute(:version_hash, metadata.hash)
    
    puts " ... done"
  end
end
