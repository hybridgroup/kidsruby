# this is the main entrypoint for the KidsRuby Editor
require 'rubygems'
require 'Qt'

%w{ highlighter }.each do |f|
  require "#{File.dirname(__FILE__)}/lib/#{f}.rb"
end

%w{ version runner turtle }.each do |f|
  require "#{File.dirname(__FILE__)}/app/models/#{f}.rb"
end

%w{ main }.each do |f|
  require "#{File.dirname(__FILE__)}/app/widgets/#{f}.rb"
end

app = Qt::Application.new(ARGV)

if !Qt::DBusConnection.sessionBus().connected? || !Qt::DBusConnection.sessionBus.registerService("com.kidsruby.app")
  $stderr.puts("%s\n" %  Qt::DBusConnection.sessionBus.lastError.message)
  exit(1)
end

main = MainWidget.new()
main.show()

app.exec()