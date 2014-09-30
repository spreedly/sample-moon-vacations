require 'sinatra'
require 'spreedly'
require 'rack/session/pool'
require 'json'
require_relative 'env'

use Rack::Session::Pool, :expire_after => 2592000

APP_NAME = 'Moon Vacations'

set :bind, '0.0.0.0'

helpers do
  def view(template)
    @active = template
    erb template
  end
end

before do
  @cart = session[:cart]
  @gateway = session[:gateway]
end

get '/' do
  view :index
end

get '/book' do
  view :book
end

post '/book' do
  content_type :json
  {foo: 'bar'}.to_json
end

get '/about' do
  view :about
end

get '/confirmation' do
  view :confirmation
end
