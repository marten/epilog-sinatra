class Site < ActiveRecord::Base
  include ActiveSupport::Memoizable
  
  has_many :domains
  has_many :users
  has_many :sections
  has_many :dropbox_directories

  accepts_nested_attributes_for :users

  def dropbox
    return @dropbox if @dropbox
    
    if dropbox_session
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

end
