class DropboxDirectory < ActiveRecord::Base
  belongs_to :site
  has_many :dropbox_files
  
  # def uptodate?
  #   hash and hash == site.dropbox.metadata(path).hash
  # end
  # 
  # def synchronize
  #   return if fresh?
  #   
  #   remote_files = site.dropbox.metadata(path).contents.sort(&:path)
  #   local_files  = dropbox_files.all.sort(&:path)
  #   
  #   to_create = []
  #   to_update = []
  #   to_delete = []
  #   
  #   remote_index = 0
  #   local_index  = 0
  #   
  #   while remote_index < remote_files.size and local_index < local_files.size
  #     remote = remote_files[remote_index]
  #     local  = local_files[local_index]
  #     
  #     # Remote is less than local, or we've processed all locals, so add remote.
  #     if not local || remote.path < local.path
  #       to_create << remote
  #       remote_index += 1
  #       next
  #     end
  #     
  #     # Local is less than remote, or we've processed all remotes, so delete local
  #     if not remote || remote.path > local.path
  #       to_delete << local
  #       local_index += 1
  #       next
  #     end
  # 
  #     # Remote and local are at the same file. We might need to update
  #     if remote.path == local.path
  #       # TODO, need to know what method to call on remote for this
  #       # if not remote.date == local.date
  #       #   to_update << {:remote => remote, :local => local}
  #       # end
  #     end
  #   end
  #   
  #   to_create.each {|i| dropbox_files.create(:path => i.path, :date => i.date, :size => i.bytes, :contents => site.dropbox.download(i.path)) }
  #   to_update.each {|i| i[:local].update_attributes(:date => i[:remote].date, :size => i[:remote].bytes, :contents => site.dropbox.download(i[:remote].path))}
  #   to_delete.each {|i| i.delete }
  # end
end
