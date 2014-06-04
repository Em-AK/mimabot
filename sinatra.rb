require 'sinatra'
require 'pry'
require "active_record"

ActiveRecord::Base.establish_connection(
  :adapter  => :sqlite3,
  :database => 'development.sqlite3'
)

class Fragment < ActiveRecord::Base
end

get '/' do
  binding.pry
  Fragment.all.map {|t| t.content}
end
