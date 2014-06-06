require 'sinatra'
require 'pry'
require "active_record"

ActiveRecord::Base.establish_connection(
  :adapter  => :sqlite3,
  :database => 'development.sqlite3'
)

class Fragment < ActiveRecord::Base
end

settings.root = `pwd`.strip  
set :haml, :format => :html5
get '/' do
  @fragments = Fragment.all
  haml :index
end
