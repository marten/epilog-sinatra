class PagesController < ApplicationController
  before_filter :load_dropbox_session

  def index
    render :text => "hello!"
  end

  def show
    render :text => @dropbox.download("/Site/" + params[:path])
  end

  protected

  def load_dropbox_session
    @dropbox = @site.dropbox
  end
end
