# encoding: UTF-8

require 'sinatra'
require 'slim'
require 'sinatra/sequel'
require 'rack-flash'
require 'json'
require_relative 'helpers'
include App::Helpers
include App::OrderManagement

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
  # Get order from DB or create if necessary
  until @order = database[:orders].first(date: today)
    database[:orders].insert(date: today)
  end
  @restaurants = database[:restaurants].order(:name).all.map{|u| u[:name]}
  @usernames = database[:users].order(:name).all.map{|u| u[:name]}
  @order_items = database[:order_items].filter(date: today).order(:dish, :user).all
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
  set_order(order_items)
  redirect to('/')
end

get '/who' do
  @usernames = database[:users].order(:name).all.map{|u| u[:name]}
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
  
  # Get user from DB or create if necessary
  until session[:user] = database[:users].first(:name => params[:username].strip)
    database[:users].insert(:name => params[:username].strip)
  end
  
  redirect to('/')
end