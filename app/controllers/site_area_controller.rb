class SiteAreaController < ApplicationController
  before_filter :load_domain_and_site
  before_filter :load_dropbox_session
  
  protected
  
  def load_domain_and_site
    @site = Site.where(:domain => request.subdomain).first
  end
  
  def load_dropbox_session
    @dropbox = @site.dropbox
  end
end
