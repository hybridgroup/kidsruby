# this is the main entrypoint for the KidsRuby Editor
require 'rubygems'
require 'Qt'

%w{ highlighter }.each do |f|
  require "#{File.dirname(__FILE__)}/lib/#{f}.rb"
end

%w{ version ruby_highlighter runner }.each do |f|
  require "#{File.dirname(__FILE__)}/app/models/#{f}.rb"
end

%w{ main controls editor output }.each do |f|
  require "#{File.dirname(__FILE__)}/app/widgets/#{f}.rb"
end

app = Qt::Application.new(ARGV)

# if !Qt::DBusConnection.sessionBus().connected?
#   Qt::MessageBox::information(self, tr('KidsRuby v' + KidsRuby::VERSION), "Cannot connect to the D-BUS session bus.\n" \
#   "Please check your system settings and try again.\n")
#   return 1
# end

# if !Qt::DBusConnection::sessionBus.connected?
#   $stderr.puts("Cannot connect to the D-BUS session bus.\n" \
#                   "To start it, run:\n" \
#                   "\teval `dbus-launch --auto-syntax`\n")
#   exit(1)
# end
if !Qt::DBusConnection.sessionBus.registerService("com.kidsruby.app")
  $stderr.puts("%s\n" %  Qt::DBusConnection.sessionBus.lastError.message)
  exit(1)
end


main = MainWidget.new()
main.show()

app.exec()