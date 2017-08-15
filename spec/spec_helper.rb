require 'airborne'
require 'faker'
require_relative '../app'

ENV['RACK_ENV'] ='development'


RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
end


Airborne.configure do |config|
  config.rack_app = Sinatra::Application
end