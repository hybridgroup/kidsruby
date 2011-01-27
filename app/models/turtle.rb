# interface to communicate with the javascript turtle object
class TurtleInterface < Qt::Object
  q_classinfo("D-Bus Interface", "com.kidsruby.Turtle")
  
  slots 'init_turtle()', 'background(const QString&)', 'pensize(int)', 'pencolor(const QString&)', 'goto(int, int)', 'setheading(int)', 
        'forward(int)', 'backward(int)', 'turnleft(int)', 'turnright(int)', 'draw()'
  
  def initialize(main)
    super
    
    @main_widget = main
    @main_frame = @main_widget.page.mainFrame
    Qt::DBusConnection.sessionBus.registerObject("/Turtle", self, Qt::DBusConnection::ExportAllSlots)
  end

  def init_turtle
    code = "initTurtle();"
    @main_frame.evaluateJavaScript(code)
  end

  # ex: blue
  def background(color)
    code = "callTurtle(['fillstyle', '#{color}']);"
    @main_frame.evaluateJavaScript(code)
  end

  # ex: 2
  def pensize(size)
    code = "callTurtle(['pensize', #{size}]);"
    @main_frame.evaluateJavaScript(code)
  end

  # ex: yellow
  def pencolor(color)
    code = "callTurtle(['penstyle', '#{color}']);"
    @main_frame.evaluateJavaScript(code)
  end

  def goto(x, y)
    code = "callTurtle(['jump', #{x}, #{y}]);"
    @main_frame.evaluateJavaScript(code)
  end

  def setheading(heading)
    code = "callTurtle(['angle', #{heading}]);"
    @main_frame.evaluateJavaScript(code)
  end

  def forward(distance)
    code = "callTurtle(['go', #{distance}]);"
    @main_frame.evaluateJavaScript(code)
  end

  def backward(distance)
    code = "callTurtle(['back', #{distance}]);"
    @main_frame.evaluateJavaScript(code)
  end

  def turnleft(degrees)
    code = "callTurtle(['turn', #{-degrees.abs}]);"
    @main_frame.evaluateJavaScript(code)
  end

  def turnright(degrees)
    code = "callTurtle(['turn', #{degrees.abs}]);"
    @main_frame.evaluateJavaScript(code)
  end
  
  def draw
    code = "callTurtle(['draw']);"
    @main_frame.evaluateJavaScript(code)
  end
end