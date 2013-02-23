# encoding: UTF-8

require 'sinatra'
require 'sinatra/sequel'
require 'rack-flash'

configure do
  enable :logging
  enable :sessions
  set :session_secret, 'cojaplace.secret'
  use Rack::Flash
  set :database, "sqlite://#{settings.environment}.db"
end


migration "Create users" do
 database.create_table :users do
   primary_key :id, :null => false
   text :name, :unique => true, :null => false
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

get '/' do
  redirect to('/who') unless session[:user]
  haml :manager
end

get '/who' do
  @usernames = database[:users].all.map{|u| u[:name]}
  haml :who
end