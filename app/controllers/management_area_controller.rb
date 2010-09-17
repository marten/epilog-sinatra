class ManagementAreaController < ApplicationController
  before_filter :load_domain_and_site
  
  protected
  
  def load_domain_and_site
    @domain = Domain.where(:domain_name => request.host).first
    @site = @domain.site if @domain
  end
end
