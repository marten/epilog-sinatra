# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Admin.create(:email => "marten@epilogapp.com", :password => "asdfasdf", :password_confirmation => "asdfasdf")

# Site and data for www.epilogapp.com
@www = Site.create(:title => "Epilog Website", :domain => "www")

# Site and data for marten.epilogapp.com
@marten = Site.create(:title => "Marten Epilogged", :domain => "marten")