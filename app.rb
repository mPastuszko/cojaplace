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
end

migration "Create users" do
 database.create_table :users do
   text :name, :primary_key => true, :unique => true, :null => false
 end
 ['Daniel',
  'Grzesiek',
  'Łukasz',
  'Maciek',
  'Marcin J.',
  'Marcin O.',
  'Marcin T.',
  'Maurycy',
  'Mikołaj',
  'Piotrek',
  'Wojtek'].each do |name|
    database[:users].insert(name: name)
  end
end

migration "Create restaurants" do
  database.create_table :restaurants do
    text :name, :primary_key => true, :unique => true, :null => false
  end
  ['Phuong Dong',
   'pizzeriaservice.pl'].each do |name|
     database[:restaurants].insert(name: name)
   end
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