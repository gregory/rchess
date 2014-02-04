require 'rubygems'
require 'bundler/setup'
Bundler.require(:test)

require_relative '../lib/rchess'
$LOAD_PATH <<  File.dirname(__FILE__)

RSpec.configure do |config|
end
