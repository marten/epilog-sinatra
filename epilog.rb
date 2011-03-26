# myapp.rb
require 'sinatra'
require 'haml'
a = 10

class Controller

  def initialize(name)
    puts "aangenaam, ik ben #{name}"
    @name = name
  end

  def get_child(name)   
    case name
    when 'blog'
      dir = BlogController.new(name)
    else
      dir = SiteController.new(name)
    end
    return dir
  end

  def has_children?
    return false
  end
  
  def find(path_array)
    return self if path_array.size <= 1
      
    dir = get_child(path_array[0])
    if dir.has_children?
      return dir.find(path_array[1..-1])
    else
      return dir
    end
  end
end

class BlogController < Controller; end
class SiteController < Controller
  def has_children?
    return true
  end
end
class AlbumController < Controller; end

@@root = SiteController.new('')

def path_array(path)
  path.split('/')[1..-1] || []
end

before do
  @dir = @@root.find(path_array(request.path_info))
  puts "hoi" + a.to_s
end

set(:kind) { |value| condition { @dir.is_a?(value) } }

get '*', :kind => AlbumController do
  'je moeder is een album'
end

get '(.*)/view/123$', :kind => AlbumController do

end

# voor blog
get '*', :kind => BlogController do
  '<!DOCTYPE html><html>Hello world! I feel blogtastic!!!'
end

get '*', :kind => SiteController do
  'hoi site'
end

get '*' do
  'jouw soort kennen we hier niet'
end
