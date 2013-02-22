# encoding: UTF-8

require 'sinatra'
require 'sinatra/sequel'
require 'rack-flash'

configure do
  enable :logging
  enable :sessions
  set :session_secret, 'cojaplace.secret'
  use Rack::Flash
  set :database, 'sqlite://db.db'
end

#migration "Create users" do
#  database.create_table :guests do
#    timestamp :registered_at, :null => false
#    timestamp :activated_at
#    text :email, :primary_key => true, :null => false
#    boolean :workshop1, :default => false, :null => false
#    boolean :workshop2, :default => false, :null => false
#    boolean :remind, :default => true, :null => false
#    text :activation_key, :size => 32, :null => false
#    boolean :active, :default => false, :null => false
#  end
#end

get '/' do
  redirect to('/who') unless session[:user]
  haml :manager
end

get '/who' do
  haml :who
end