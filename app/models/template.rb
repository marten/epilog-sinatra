class Template < ActiveRecord::Base
  belongs_to :site
  has_one :dropbox_file, :as => :item
end
