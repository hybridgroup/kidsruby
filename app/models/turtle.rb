# interface to communicate with the javascript turtle object
class TurtleInterface < Qt::Object
  q_classinfo("D-Bus Interface", "com.kidsruby.Turtle")
  
  slots 'init_turtle()', 'command_turtle(const QString&)', 'background(const QString&)', 'int width()', 'int height()'
  
  def initialize(main)
    super(main)
    
    @main_widget = main
    @main_frame = @main_widget.page.mainFrame
    Qt::DBusConnection.sessionBus.registerObject("/Turtle", self, Qt::DBusConnection::ExportAllSlots)
  end

  def init_turtle
    code = "initTurtle();"
    @main_frame.evaluateJavaScript(code)
  end

  def command_turtle(commands)
    code = "getTurtle()." + commands ;
    @main_frame.evaluateJavaScript(code)
  end

  def background(color)
    code = "setTurtleBackground('#{color}');"
    return @main_frame.evaluateJavaScript(code)
  end

  def width
    code = "callTurtle(['width']);"
    return @main_frame.evaluateJavaScript(code)
  end

  def height
    code = "callTurtle(['height']);"
    return @main_frame.evaluateJavaScript(code)
  end
end