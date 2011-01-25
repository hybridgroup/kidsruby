require "qtwebkit"
# this is the main view widget
class Runner < Qt::Process
  def read_data
    out = self.readAllStandardOutput.data
    out.split("\n").each do |line|
      code = "updateStdOut('#{@coder.encode(line)}<br/>')"
      @main_widget.evaluateJavaScript(code)
    end
  end
  
  def read_error
    err = self.readAllStandardError.data
    err.split("\n").each do |line|
      code = "updateStdErr('#{@coder.encode(line)}<br/>')"
      @main_widget.evaluateJavaScript(code)
    end
  end
end

class MainWidget < Qt::WebView
  slots 'evaluateRuby(QString)', 'setupQtBridge()'
    
  def initialize(parent = nil)
    super(parent)
    
    self.window_title = "KidsRuby v" + KidsRuby::VERSION    
    
    @frame = self.page.mainFrame
    
    Qt::Object.connect(@frame,  SIGNAL("javaScriptWindowObjectCleared()"), self, SLOT('setupQtBridge()') )
    
    self.load Qt::Url.new("#{File.dirname(__FILE__)}/../../public/index.html")
    show
  end
  
  private
  
  def setupQtBridge
    @frame.addToJavaScriptWindowObject("QTApi", self);
  end
  
  def evaluateRuby(code)
    runner = Runner.new(@frame)
    runner.run(code)
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

