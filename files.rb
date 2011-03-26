@@extensions = {}

class EpilogFile

  @@extensions.default = EpilogFile
  
  def initialize(filename)
    @filename = filename
  end
    
  def self.register_extensions(extensions)
    extensions.each do |ext|
      raise "Je hele familie definieert extensions meerdere keren" if @@extensions.has_key?(ext)
      @@extensions[ext] = self
    end
  end
  
  def self.for(filename)
    if File.exists?(filename)
      
      @@extensions[File.extname(filename)].new(filename)
    else
      puts 'hoi'
      raise Sinatra::NotFound
    end
  end

  def output
    {:send_file => @filename}
  end
end

class MarkdownFile < EpilogFile
  register_extensions [".markdown"]

  def output
    {
      :raw_html => RDiscount.new(File.read(@filename)).to_html
    }
  end
  
end
