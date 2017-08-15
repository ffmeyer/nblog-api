# app.rb
require 'sinatra'
require 'sinatra/namespace'
require 'sinatra/reloader' if development?

require_relative 'endpoints/posts'

# Rota padrão
get '/' do  
  @env = ENV['RACK_ENV'].to_s.upcase
  "Welcome to nBlog API v2.3 | Environment: #{@env}."
end
