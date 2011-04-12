class Site
  include Mongoid::Document
  belongs_to :section
  belongs_to :directory, class_name: "AbstractDirectory"

	field :key
  field :title
	field :path
  field :section_map

  def protocol
    URI.parse(path).protocol
  end

	def sync!
    self.section = SimpleSection.new(:path => "/", :directory => directory) unless section
    section.sync!
    self.section_map = section.section_map
    save
  end
  
end
