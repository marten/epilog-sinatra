class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :load_domain_and_site
  
  protected
  
  def load_domain_and_site
    logger.error "Got domain: #{request.host}"
    @domain = Domain.where(:domain_name => request.host).first
    @site = @domain.site
  end
  
end
