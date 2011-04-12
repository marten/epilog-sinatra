require File.expand_path("../../config/boot", __FILE__)
require 'pathname'
root_path = "/home/mark/devel/epilog/site"

root = Pathname.new(root_path)

def recurse(path, parent = nil)
  puts path.expand_path
  dir = DiskDirectory.find_or_create_by(path: path.expand_path.to_s)
  dir.directory = parent
  dir.save

  path.children.each do |child|
    if child.directory?
      recurse(child, dir)
    elsif child.file?
      file = DiskFile.find_or_create_by(path: child.expand_path.to_s)
      file.directory = dir
      file.save
    end
  end

  return dir
end

site = Site.find_or_create_by(key: "test")

dir = recurse(root)
dir.site = site
dir.save

site.sync!
