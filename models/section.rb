class Section
  include Mongoid::Document
  has_one :site
  belongs_to :directory, class_name: "AbstractDirectory"
  belongs_to :parent, class_name: "Section"
  has_many :children, class_name: "Section"
  field :path

  def sync!
    directory.directories.each do |dir|
      section_path = path + dir.name
      section = children.where(:path => section_path)
      
			unless section
			  # TODO OOk ander soort sections maken, aan de hand van dir.extension
        section = SimpleSection.new(:path => section_path, :directory => dir)
			  children << section
			end

      section.sync!
	  end
	end

  def section_map
    [{:path => path, :section => self}, 
     children.map(&:section_map)].flatten
  end
end
