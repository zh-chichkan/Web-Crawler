require './app'

 use Rack::Reloader
 use Rack::Builder

 map '/' do
    run App.new
 end

 map '/crawler' do
 end
