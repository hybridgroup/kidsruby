require "qtwebkit"
# this is the main view widget
class Runner < Qt::Process
  attr_reader :stdout
  def read_data
    @stdout = self.readAllStandardOutput()
    emit :outputReady
  end
end

class MainWidget < Qt::WebView
  slots 'QString evaluateRuby(const QString&)'
  def initialize(parent = nil)
    super(parent)
    
    self.window_title = "KidsRuby v" + KidsRuby::VERSION    
    
    self.load Qt::Url.new("#{File.dirname(__FILE__)}/../../public/index.html")
    
    frame = self.page.mainFrame
    @main = frame
    frame.addToJavaScriptWindowObject("QTApi", self);
    
    Qt::Object.connect(frame, SIGNAL("javaScriptWindowObjectCleared()"), self, SLOT('evaluateRuby()') )
    
    show
  end
  
  private
  
  def evaluateRuby(code)
    runner = Runner.new(@main)
    runner.run(code)
    runner.stdout
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

