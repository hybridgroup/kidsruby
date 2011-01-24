require "qtwebkit"
# this is the main view widget
class MainWidget < Qt::WebView
  def initialize(parent = nil)
    super(parent)
    
    # self.window_title = 'KidsRuby v' + KidsRuby::VERSION
    # resize(700, 500)
    # 
    # @controls = ControlsWidget.new(self)
    # @editor = EditorWidget.new(self)
    # 
    # left_side = Qt::VBoxLayout.new
    # left_side.add_widget(@editor, 4)
    # left_side.add_widget(@controls, 1)
    # 
    # @out = OutputWidget.new
    # 
    # right_side = Qt::VBoxLayout.new
    # right_side.add_widget(@out)
    # 
    # self.layout = Qt::HBoxLayout.new do
    #   add_layout left_side
    #   add_layout right_side
    # end
    
    self.window_title = "KidsRuby v" + KidsRuby::VERSION
    
    self.load Qt::Url.new("#{File.dirname(__FILE__)}/../../public/index.html")
    show
  end
  
  def append(text)
    current_output.append(text)
  end
  
  def current_code
    @editor.current_code
  end
  
  def current_output
    @out
  end
end

