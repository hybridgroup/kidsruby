require "rubygems"

def test_mode?
  ENV['KIDSRUBY_ENV'] == "test" 
end

%w{ interface stdio dialogs turtle rubywarrior }.each do |f|
  require File.expand_path(File.dirname(__FILE__) + "/kidsruby/#{f}.rb")
end
