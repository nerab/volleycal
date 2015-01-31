require 'rubygems'

require 'bundler'
Bundler.require

# required if this is not a gem
$:.unshift File.join(File.dirname(__FILE__), *%w[lib])

require 'volleycal'

use Rack::CommonLogger
use Rack::ShowExceptions
use Rack::ShowStatus

run Volleycal::WebApp.new
