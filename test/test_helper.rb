require 'minitest/autorun'
require "mocha/mini_test"

def set_test_mode(state=:on)
  ENV['KIDSRUBY_ENV'] = "test"
end

set_test_mode(:on)

require_relative "../lib/kidsruby"
