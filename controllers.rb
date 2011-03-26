class Controller
  class ControllerNotFoundException < Exception; end

  @@controllers = []

  def self.register_controller(regexp)
    @@controllers << {:matcher => regexp, :controller => self}
  end
  
  def initialize(name, parent = nil)
    @name = name
    @parent = parent
    @children = {}
  end

  def pathname
    return @name if not @parent
    File.join(@parent.pathname, @name)
  end
  
  def get_child(name)
    if not @children[name]
      if not Dir.exists?(File.join(pathname, name))
        raise ControllerNotFoundException.new("We don't know #{File.join(pathname, name)}")
      end

      @@controllers.each do |options|
        return options[:controller].new(name, self) if name =~ options[:matcher]
      end
    end

    raise ControllerNotFoundException.new("No controller registered for #{pathname}")
  end

  def has_children?
    return false
  end
  
  def find(path_array)
    return self if path_array.size <= 0

    begin
      dir = get_child(path_array[0])
    rescue ControllerNotFoundException => e
      if path_array.size == 1
        return self
      else
        raise Sinatra::NotFound
      end
    end
    
    if dir.has_children?
      return dir.find(path_array[1..-1])
    else
      return dir
    end
  end
end

class BlogController < Controller
  register_controller /^blog$/
end

class AlbumController < Controller
  register_controller /^albums?$/
end

class SiteController < Controller
  register_controller /.*/
  def has_children?
    return true
  end
end
