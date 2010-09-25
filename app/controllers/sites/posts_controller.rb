require 'mime/types'
require 'url_to_file_mapper'

class Sites::PostsController < SiteAreaController

  def index
    render :text => "Index pages are TODO"
  end

  def show
    @date = Time.gm(params[:year], params[:month], params[:day])
    @slug = params[:slug]
    @filename = "Site/blog/#{@date.strftime("%Y-%m-%d")}-#{@slug}"
    
    @file = @site.blog.dropbox_files.where("path LIKE ?", "#{@filename}.%").first
    @post = @file.item
    
    if (not @file) or (not @post) or (not Post === @post)
      render :text => "404 #{@filename}" and return
    end
    
    # Render things like markdown and textile
    case File.extname(@file.path)
    when ".html"
      @rendered_content = @file.contents
    when ".markdown"
      @rendered_content = RDiscount.new(@file.contents).to_html
    else
      @rendered_content = @file.contents
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
