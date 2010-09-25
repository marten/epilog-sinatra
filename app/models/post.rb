class Post < ActiveRecord::Base
  belongs_to :site
  
  def self.sync
    site.dropbox.metadata('Site/blog')
  end
end
