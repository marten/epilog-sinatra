require 'mime/types'
require 'url_to_file_mapper'

class Sites::PagesController < SiteAreaController

  def show
    ### This is going to be one monstrous action. Sorry about that. We'll clean it up later.
    
    ### We'll need to find out which file we want to get out of dropbox
    mapped_path  = "/Site" + UrlToFileMapper.map(request.fullpath)

    if File.extname(mapped_path) == '.html'
      paths_to_try = UrlToFileMapper.all_extension_variants_for(mapped_path, ['.markdown', '.textile'])
    else
      paths_to_try = [mapped_path]
    end

    @path = @data = nil
    paths_to_try.each do |path|
      begin
        @data = @dropbox.download(path)
        @path = path
        break
      rescue Dropbox::UnsuccessfulResponseError => e
        logger.debug "Tried getting #{path} but got #{e.message}"
        next
      end
    end
  
    logger.debug "Went with #{@path}"

    # 404 if we didn't get anything
    render :text => "404 not found: #{paths_to_try.inspect}" and return if not @data

    # Render things like markdown and textile
    case File.extname(@path)
    when ".html"
      @rendered_content = @data
    when ".markdown"
      @rendered_content = RDiscount.new(@data).to_html
    else
      @rendered_content = @data
    end
  
    # Render layouts
    if File.extname(mapped_path) == '.html'
      logger.info "Rendering layout"
      @template = @dropbox.download(File.join("/Site/templates/default.liquid"))
      @rendered_data = Liquid::Template.parse(@template).render('content' => @rendered_content, 'site' => @site)
    else
      @rendered_data = @rendered_content
    end
    
    # Next we need to find out what kind of file this is.
    # We use the gem 'mime-types' for this.
    @mime = MIME::Types.of(mapped_path).first
    
    # TODO Determine disposition based on mimetype
    send_data @rendered_data, :type => @mime.to_s, :disposition => 'inline'
  end

end
