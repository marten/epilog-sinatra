require 'mime/types'

class Sites::PagesController < SiteAreaController

  def show
    ### This is going to be one monstrous action. Sorry about that. We'll clean it up later.
    
    # We'll need to find out which file we want to get out of dropbox
    filename = params[:path]
    
    # Now get that file
    data = @dropbox.download("/Site/" + params[:path])
    
    # Next we need to find out what kind of file this is.
    # We use the gem 'mime-types' for this.
    mime = MIME::Types.of(filename).first

    send_data data, :type => mime.to_s, :disposition => 'inline'
  end

end
