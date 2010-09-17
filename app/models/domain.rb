class Domain < ActiveRecord::Base
  belongs_to :site
  
  validates_uniqueness_of :domain_name
end
