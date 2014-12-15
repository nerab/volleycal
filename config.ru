require 'rubygems'
require 'bundler'
Bundler.require

require 'volleycal'

use Rack::CommonLogger
use Rack::ShowExceptions
use Rack::ShowStatus

run Volleycal::WebApp.new
