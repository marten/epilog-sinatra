# myapp.rb
require 'sinatra'
require 'haml'
a = 10

class Directory

  def initialize(name)
    puts "aangenaam, ik ben #{name}"
    @name = name
  end

  def get_child(name)   
    case name
    when 'blog'
      dir = BlogDirectory.new(name)
    else
      dir = SiteDirectory.new(name)
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

class BlogDirectory < Directory; end
class SiteDirectory < Directory
  def has_children?
    return true
  end
end
class AlbumDirectory < Directory; end

@@root = SiteDirectory.new('')

def path_array(path)
  path.split('/')[1..-1] || []
end

before do
  @dir = @@root.find(path_array(request.path_info))
  puts "hoi" + a.to_s
end

set(:kind) { |value| condition { @dir.is_a?(value) } }

get '*', :kind => AlbumDirectory do
  'je moeder is een album'
end

get '(.*)/view/123$', :kind => AlbumDirectory do

end

# voor blog
get '*', :kind => BlogDirectory do
  '<!DOCTYPE html><html>Hello world! I feel blogtastic!!!'
end

get '*', :kind => SiteDirectory do
  'hoi site'
end

get '*' do
  'jouw soort kennen we hier niet'
end
