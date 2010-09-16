class Site < ActiveRecord::Base
  has_many :domains
  has_many :sections
end
