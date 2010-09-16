source 'http://rubygems.org'

gem 'rails', '3.0.0.rc2'

group :development, :test do
  gem 'mysql'
end

group :production do
  gem 'pg'
end

gem 'dropbox'

# To use debugger
# gem 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end

group :test, :development do
  gem 'awesome_print'
  gem "rspec-rails", ">= 2.0.0.beta.19"
  gem "autotest"
  gem "webrat"
end

