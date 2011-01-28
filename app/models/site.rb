class Site < ActiveRecord::Base
  include ActiveSupport::Memoizable
  
  has_many :domains
  has_many :users
  has_many :posts, :include => :dropbox_file
  has_many :dropbox_directories
  has_many :dropbox_files

  has_many :templates
  has_many :stylesheets

  accepts_nested_attributes_for :users

  liquid_methods :posts

  def dropbox
    return @dropbox if @dropbox
    
    if dropbox_session and not dropbox_session.empty?
      @dropbox ||= Dropbox::Session.deserialize(dropbox_session)
      @dropbox.mode = :dropbox
      @dropbox
    else
      @dropbox = Dropbox::Session.new(DROPBOX_KEY, DROPBOX_SECRET)
      update_attribute(:dropbox_session, @dropbox.serialize)
      @dropbox
    end
  end
  
  def path
    '/Site'
  end
  
  def blog;        dropbox_directories.find_or_create_by_path("/Site/blog");        end
  def photos;      dropbox_directories.find_or_create_by_path("/Site/photos");      end
  def albums;      dropbox_directories.find_or_create_by_path("/Site/albums");      end
  
  def templates;   dropbox_directories.find_or_create_by_path("/Site/templates");   end
  def stylesheets; dropbox_directories.find_or_create_by_path("/Site/stylesheets"); end

  def synchronize
    blog.synchronize
    #photos.synchronize
    #albums.synchronize
    templates.synchronize
    stylesheets.synchronize
  end

end
