class AbstractDirectory
  include Mongoid::Document
  belongs_to :site
  belongs_to :directory, class_name: "AbstractDirectory"
  has_many :files, class_name: "AbstractFile"
  has_many :directories, class_name: "AbstractDirectory"
  field :path

  def name
    File.basename(path)
  end

  def extension
    File.extname(path)
  end
end
