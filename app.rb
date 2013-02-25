# encoding: UTF-8

require 'sinatra'
require 'sinatra/sequel'
require 'rack-flash'
require 'json'

configure do
  enable :logging
  enable :sessions
  set :session_secret, 'cojaplace.secret'
  use Rack::Flash
  set :database, "sqlite://#{settings.environment}.db"
  Dir["db/migrations/*.rb"].each {|file| require_relative file }
end

get '/' do
  redirect to('/who') unless session[:user]
  @restaurants = database[:restaurants].order(:name).all.map{|u| u[:name]}
  @usernames = database[:users].order(:name).all.map{|u| u[:name]}
  haml :manager
end

get '/who' do
  @usernames = database[:users].order(:name).all.map{|u| u[:name]}
  haml :who
end

post '/who' do
  if params[:username].empty?
    flash[:error] = {
      field: :username,
      message: "Pierwej podaj imię!"
    }
    return redirect to('/who')
  end
  
  # Get user if exists in DB or create if necessary
  until session[:user] = database[:users].first(:name => params[:username].strip)
    database[:users].insert(:name => params[:username].strip)
  end
  
  redirect to('/')
end