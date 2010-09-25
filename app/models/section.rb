class Blog
  
  def initialize(site)
    @site = site
  end
  
  def synchronize
    metadata = @site.dropbox.metadata('/Site/#{slug}')
    if dropbox_hash != metadata.hash
      posts = self.posts.all
      files = metadata.contents
      
      files.each do |file|
        post = posts.find {|i| i.path == file.path }
        if post
          next if post.dropbox_modified == file.modified
          post.synchronize!
        else
          self.posts.create_from_path()
    end
  end
end
