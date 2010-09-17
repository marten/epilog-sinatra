class Admin::SitesController < AdminAreaController
  
  def index
    @sites = Site.all
  end
  
  def new
    @site = Site.new
  end
  
  def create
    @site = Site.new(params[:site])
    
    if @site.save
      redirect_to admin_sites_path
    else
      render :action => :new
    end
  end
  
  def authorize
    @site = Site.find(params[:id])
    @site.dropbox.authorize(params)
    @site.dropbox_session = @site.dropbox.serialize
    @site.save
    redirect_to admin_sites_path
  end
  
end
