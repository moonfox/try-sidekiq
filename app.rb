require 'rubygems'
require 'bundler/setup'

ENV["RACK_ENV"] ||= "development"

Bundler.require(:default, ENV["RACK_ENV"].to_sym)

ROOT_PATH = File.expand_path("../", __FILE__)

LOAD_PATH = %w(config app)

LOAD_PATH.each do |dir|
  Dir.glob("#{ROOT_PATH}/#{dir}/**/*.rb") do |file|
    puts file
    require file
  end
end