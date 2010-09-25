class Post < ActiveRecord::Base
  belongs_to :site
  has_one :dropbox_file, :as => :item
  
  validates_presence_of :site
  validates_presence_of :dropbox_file
  
  liquid_methods :title, :body
  
  def title
    dropbox_file.path
  end
  
  def body
    dropbox_file.contents
  end
end
