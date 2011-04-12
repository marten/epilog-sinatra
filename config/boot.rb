require 'rubygems'
# Set up gems listed in the Gemfile.
gemfile = File.expand_path('../../Gemfile', __FILE__)
begin
  ENV['BUNDLE_GEMFILE'] = gemfile
  require 'bundler'
  Bundler.setup
rescue Bundler::GemNotFound => e
  STDERR.puts e.message
  STDERR.puts "Try running `bundle install`."
  exit!
end if File.exist?(gemfile)

require 'bundler/setup'
require 'sinatra/base'
require 'haml'
require 'rdiscount'
require 'yaml'
require 'mongoid'

# TODO ActiveSupport::Dependencies leren over onze directories
require_relative "../config/mongoid"
require_relative "../models/disk_directory"
require_relative "../models/disk_file"
require_relative "../models/site"
require_relative "../models/section"
require_relative "../models/page"

