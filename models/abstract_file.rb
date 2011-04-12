class AbstractFile
  include Mongoid::Document
  belongs_to :directory, class_name: "AbstractDirectory"
  field :path
end
