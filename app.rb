require 'sinatra'
require 'shotgun'

require_relative 'league'

get '/' do
  @leagues = League.all
  erb :index
end

get '/leagues/:id' do

end