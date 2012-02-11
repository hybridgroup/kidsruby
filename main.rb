# this is the main entrypoint for the KidsRuby Editor
require 'rubygems'
require 'Qt'

%w{ languages frame_writer runner_writer stdin_rejecter version runner turtle }.each do |f|
  require File.expand_path(File.dirname(__FILE__) + "/app/models/#{f}.rb")
end

%w{ main server }.each do |f|
  require File.expand_path(File.dirname(__FILE__) + "/app/widgets/#{f}.rb")
end

@@app = Qt::Application.new(ARGV)

@@main = MainWidget.new()
@@main.show()

@@app.exec()
