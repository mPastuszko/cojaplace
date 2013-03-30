# encoding: UTF-8

require 'sinatra'
require 'slim'
require 'coffee_script'
require 'sinatra/sequel'
require 'rack-flash'
require 'json'
require_relative 'helpers'
include App::Helpers
include App::OrderManagement
include App::UsersManagement
include App::RestaurantsDishesRegister

configure do
  enable :logging
  enable :sessions
  set :session_secret, 'cojaplace.secret'
  use Rack::Flash
  set :database, "sqlite://#{settings.environment}.db"
  Dir["db/migrations/*.rb"].each {|file| require_relative file }
end

configure :test do
  disable :logging
end

get '/' do
  redirect to('/who') unless session[:user]
  @order = order
  @restaurants = restaurants
  @dishes_with_prices = dishes_with_prices(
    @order[:restaurant].empty? ? nil : @order[:restaurant])
  @dishes = @dishes_with_prices.map {|e| e[:dish]}.uniq.sort
  @usernames = usernames
  @order_items = order_items
  slim :manager
end

post '/today_order' do
  set_restaurant(params[:restaurant])
  order_items = [
    params[:user].map(&:strip),
    params[:dish].map(&:strip),
    params[:price].map(&:strip),
    params[:notes].map(&:strip)].
    transpose.
    # Reject all items that have empty dish, price and notes
    reject { |i| i[1..-1].reject(&:empty?).empty? }
  set_items(order_items)

  dishes_with_prices = order_items.map {|i| i[1..2] }
  update_register(params[:restaurant], dishes_with_prices)

  redirect to('/')
end

get '/who' do
  @usernames = usernames
  slim :who
end

post '/who' do
  if params[:username].empty?
    flash[:error] = {
      field: :username,
      message: "Pierwej podaj imię!"
    }
    return redirect to('/who')
  end
  
  session[:user] = user(params[:username].strip)
  
  redirect to('/')
end

get "/js/*.js" do
  content_type "text/javascript"
  coffee File.join('coffee', params[:splat].first).to_sym
end
