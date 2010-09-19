class UrlToFileMapper
  class << self
    def map(request_path, options = {})
      options.reverse_merge!(:index => "index.html", :extension => ".html")
      
      dirname  = File.dirname(request_path)
      filename = File.basename(request_path)
      extname  = File.extname(request_path)
      
      # DEBUG
      puts [request_path, dirname, filename, extname].inspect
      
      # / -> /index.html
      # /foobar/ -> /foobar/index.html
      return request_path + options[:index] if request_path.ends_with?('/')

      # /foo.ext -> /foo.ext
      return request_path if extname and not extname.blank?
      
      # /foo -> /foo.html
      return request_path + options[:extension]
      
      # Fallback
      return request_path
    end
    
    def all_extension_variants_for(request_path, extensions = [])
      dirname  = File.dirname(request_path)
      extname  = File.extname(request_path)
      filename = File.basename(request_path, extname)
      
      extensions = ([extname] + extensions).uniq
      
      return extensions.map do |ext|
        File.join(dirname, filename) + ext
      end
      
      # Fallback
      return [request_path]
    end
  end
end