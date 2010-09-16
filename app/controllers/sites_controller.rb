# TEMPORARY CONTROLLER

class SitesController < ApplicationController
  def index
    render :text => @site.name 
  end
end
