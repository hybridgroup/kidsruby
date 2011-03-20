require "rubygems"
%w{ interface dialogs turtle stdio }.each do |f|
  require File.expand_path(File.dirname(__FILE__) + "/kidsruby/#{f}.rb")
end
