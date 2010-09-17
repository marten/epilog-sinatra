class AdminAreaController < ApplicationController
  before_filter :authenticate_admin!
  
  layout "admin_area"
end
