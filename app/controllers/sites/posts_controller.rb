require 'mime/types'
require 'url_to_file_mapper'

class Sites::PostsController < SiteAreaController

  def index
    render :text => "Index pages are TODO"
  end

  def show
    @date = Time.gm(params[:year], params[:month], params[:day])
    @slug = params[:slug]
    @filename = "/blog/#{@date.strftime("%Y-%m-%d")}-#{@slug}"
    
    posts = @site.dropbox.metadata('/Site/blog').contents
    post_metadata = posts.first {|i| i.path.starts_with?("Site" + @filename) }

    render :text => "404 #{@filename}" and return if not post_metadata
    
    ### We'll need to find out which file we want to get out of dropbox
    @data = @dropbox.download(post_metadata.path)
    @path = post_metadata.path
  
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
    logger.info "Rendering layout"
    @template = @dropbox.download(File.join("/Site/templates/default.liquid"))
    @rendered_data = Liquid::Template.parse(@template).render('content' => @rendered_content)
    
    # Next we need to find out what kind of file this is.
    # We use the gem 'mime-types' for this.
    @mime = MIME::Types.of(request.fullpath).first
    
    # TODO Determine disposition based on mimetype
    send_data @rendered_data, :type => @mime.to_s, :disposition => 'inline'
  end

end
