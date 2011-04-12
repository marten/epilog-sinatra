Mongoid.configure do |config|
    config.master = Mongo::Connection.new('localhost').db("epilog")
end