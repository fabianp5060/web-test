#
STDOUT.sync = true

require 'nexmo'
require 'sinatra'
require 'json'
require 'dm-core'
require 'dm-migrations'
require 'json'
require 'logger'

################################################
# Database Specific Controls
################################################

# Configure in-memory DB
DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/auth.db")

class UserDB
	include DataMapper::Resource
	property :id, Serial
	property :first_name, String
	property :last_name, String
end


get '/users' do
	@title = "Hi Derek"
	@db = UserDB.all

	puts "#{__method__}: users info: #{@db.inspect}"
	erb :users
end

post '/users' do
	puts "params: #{params}"
	add_db = UserDB.first_or_create(
		first_name: params[:firstname],
		last_name: params[:lastname]
	)
	redirect '/users'
end

UserDB.auto_migrate!