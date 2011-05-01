# interface to communicate with the javascript turtle object
class TurtleInterface < Qt::Object
  slots 'init_turtle()', 'command_turtle(const QString&)', 'background(const QString&)', 'int width()', 'int height()'
  
  def initialize(main)
    super(main)
    
    @main_widget = main
    @main_frame = @main_widget.page.mainFrame
  end

  def init_turtle
    code = "initTurtle();"
    @main_frame.evaluateJavaScript(code)
  end

  def command_turtle(commands)
    code = "getTurtle()." + URI.decode(commands) ;
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