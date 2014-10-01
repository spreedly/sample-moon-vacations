require 'sinatra'
require 'rack/session/pool'
require 'json'
require_relative 'env'

use Rack::Session::Pool, :expire_after => 2592000

APP_NAME = 'Moon Vacations'

set :bind, '0.0.0.0'

def self.get_or_post(url,&block)
  get(url,&block)
  post(url,&block)
end

helpers do
  def view(template)
    @active = template
    erb template
  end
end

before do
  @cart = {rooms: 2}
end

get '/' do
  view :index
end

get '/book' do
  view :book
end

get_or_post '/process' do
  if request.env['REQUEST_METHOD'] == 'GET'
    redirect to(:confirmation) and return
  end
  # Process transaction here ...
  #   with the Spreedly Gem https://github.com/spreedly/sample-rainbow-tails/blob/master/app/controllers/tails_controller.rb#L13-L17
  #   or a RESTful libraray https://github.com/spreedly/sample-phasers/blob/master/app/models/spreedly_core.rb#L15-L17
  content_type :json
  {success: true}.to_json
end

get '/confirmation' do
  view :confirmation
end

get '/about' do
  view :about
end

