# this is the main entrypoint for the KidsRuby Editor
require 'rubygems'
require 'Qt4'
require "#{File.dirname(__FILE__)}/app/widgets/main.rb"

app = Qt::Application.new(ARGV)

widget = MainWidget.new()
widget.show()

app.exec()