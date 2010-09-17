class Site < ActiveRecord::Base
  has_many :domains
  has_many :users

  accepts_nested_attributes_for :users

  def dropbox
    if dropbox_session
      @dropbox ||= Dropbox::Session.deserialize(dropbox_session)
      @dropbox.mode = :dropbox
    else
      @dropbox = Dropbox::Session.new(DROPBOX_KEY, DROPBOX_SECRET)
      update_attribute(:dropbox_session, @dropbox.serialize)
    end
    
    @dropbox
  end
end
