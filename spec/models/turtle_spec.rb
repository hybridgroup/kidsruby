# TurtleInterface class is a pure interface to turtle. Tests should be delegated to caller

# require_relative "../spec_helper"
# require_relative "../../app/models/turtle.rb"
# 
# describe TurtleInterface do
#   before do
#     @bus = mock('bus')
#     @bus.stubs('registerObject')
#     Qt::DBusConnection.stubs('sessionBus').returns(@bus)
#     
#     @page = mock('page')
#     @page.stubs('mainFrame')
#     @main_widget = mock('main')
#     @main_widget.stubs(:page).returns(@page)
#   end
#   
#   it "must instantiate a TurtleInterface" do
#     @turtle = TurtleInterface.new(@main_widget)
#     @turtle.wont_be_nil
#   end
# end