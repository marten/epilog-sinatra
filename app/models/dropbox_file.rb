class DropboxFile < ActiveRecord::Base
  belongs_to :dropbox_directory
end
