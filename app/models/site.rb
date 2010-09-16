class Site < ActiveRecord::Base
  has_many :domains
  has_many :sections

  def dropbox
    @dropbox ||= Dropbox::Session.deserialize(dropbox_session)
    @dropbox.mode = :dropbox
    @dropbox
  end
end
