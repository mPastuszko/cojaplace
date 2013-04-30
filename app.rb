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
include App::AccountManagement
include App::RestaurantsDishesRegister

configure do
  enable :logging
  enable :sessions
  set :session_secret, 'cojaplace.secret'
  use Rack::Flash
  set :database, "sqlite://#{settings.environment}.db"
  Dir["db/migrations/*.rb"].sort.each {|file| require_relative file }
  mime_type :ttf, 'font/ttf'
  mime_type :otf, 'font/otf'
end

configure :test do
  disable :logging
end

get '/' do
  redirect to('/who') unless session[:user]
  @order = order
  @restaurants = restaurants
  @dishes_with_prices = dishes_with_prices
  @dishes = @dishes_with_prices[@order[:restaurant]].
    keys.
    uniq.
    sort
  @usernames = usernames
  @order_items = order_items
  @creditors = creditors(session[:user][:name])
  @debtors = debtors(session[:user][:name])
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

  set_payment(params[:payer], params[:paid])

  redirect to('/')
end

post '/payback' do
  payer, amount = params[:payer], params[:amount]
  receiver = session[:user][:name]
  add_payback(today, payer, receiver, amount)

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
