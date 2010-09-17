class Sites::PagesController < SiteAreaController

  def show
    render :text => @dropbox.download("/Site/" + params[:path])
  end

end
