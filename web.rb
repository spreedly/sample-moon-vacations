require 'sinatra'
require 'spreedly'
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
  transaction = spreedly.purchase_on_gateway(
    gateway_token,
    params[:payment_method_token],
    amount_to_charge
  )
  content_type :json
  {success: transaction.succeeded?}.to_json
end

get '/confirmation' do
  view :confirmation
end

get '/about' do
  view :about
end

def spreedly
  @spreedly ||= Spreedly::Environment.new(ENV['SPREEDLY_ENVIRONMENT_KEY'], ENV['SPREEDLY_ACCESS_SECRET'], base_url: ENV['SPREEDLY_HOST'])
end

def amount_to_charge
  150000 * @cart[:rooms]
end

def gateway_token
  ENV['SPREEDLY_GATEWAY_FOR_CREDIT_CARD']
end
