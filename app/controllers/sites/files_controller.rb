require 'mime/types'
require 'url_to_file_mapper'

class Sites::FilesController < SiteAreaController

  def show
    ### This is going to be one monstrous action. Sorry about that. We'll clean it up later.
    
    ### We'll need to find out which file we want to get out of dropbox
    mapped_path  = "/Site" + UrlToFileMapper.map(request.fullpath)

    begin
      @data = @dropbox.download(mapped_path)
      @path = mapped_path
    rescue Dropbox::UnsuccessfulResponseError => e
      logger.debug "Tried getting #{path} but got #{e.message}"
      # 404 if we didn't get anything
      render :text => "404 not found: #{paths_to_try.inspect}" and return
    end
  
    logger.debug "Went with #{@path}"

    # 404 if we didn't get anything
    render :text => "404 not found: #{paths_to_try.inspect}" and return if not @data
    
    # Next we need to find out what kind of file this is.
    # We use the gem 'mime-types' for this.
    @mime = MIME::Types.of(mapped_path).first
    
    # TODO Determine disposition based on mimetype
    send_data @data, :type => @mime.to_s, :disposition => 'inline'
  end

end
