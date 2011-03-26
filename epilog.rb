# Libraries
require 'sinatra/base'
require 'haml'
require 'rdiscount'

# Onze files
require './controllers'
require './files'

def path_array(path)
  path.split('/')[1..-1] || []
end

class Epilog < Sinatra::Base
  configure do
    set :rootcontroller, SiteController.new("/home/marten/Dropbox/Site")
  end
  
  before do
    @dir = settings.rootcontroller.find(path_array(request.path_info))
  end
  
  set(:kind) { |value| condition { @dir.is_a?(value) } }
  
  get '*', :kind => AlbumController do
    'je moeder is een album'
  end

  if 3 > 2 
    # voor blog
    get '*', :kind => BlogController do
      '<!DOCTYPE html><html>Hello! I feel blogtastic!!!!'
    end
  end
  
  get '*/:file', :kind => SiteController do
    output = EpilogFile.for(File.join(@dir.pathname,params[:file])).output(self)
    if output[:send_file]
      send_file output[:send_file]
      return
    end
    
    haml :page, :locals => content
  end
  
  get '*' do
    'jouw soort kennen we hier niet'
  end
end
