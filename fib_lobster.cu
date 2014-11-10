require 'rack/lobster'
require_relative 'fib_lobster'

use FibLobster
run Rack::Lobster.new
