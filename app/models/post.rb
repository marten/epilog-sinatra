class Post < ActiveRecord::Base
  belongs_to :site
  
  has_one :dropbox_file, :as => :item
  
  def self.sync
    site.dropbox.metadata('Site/blog')
  end
end
