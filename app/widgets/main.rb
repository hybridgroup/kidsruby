require "qtwebkit"
# this is the main view widget
class Runner < Qt::Process
  def read_data
    out = self.readAllStandardOutput
    string = []
    (out.length-1).times do |i|
      string[i] = out[i].chr
    end
    string = string.join("")
    @main_widget.evaluateJavaScript('updateOutputView("' + string + '");')
  end
end

class MainWidget < Qt::WebView
  slots 'evaluateRuby(QString)'
    
  def initialize(parent = nil)
    super(parent)
    
    self.window_title = "KidsRuby v" + KidsRuby::VERSION    
    
    @frame = self.page.mainFrame
    @frame.addToJavaScriptWindowObject("QTApi", self);
    
    Qt::Object.connect(@frame, SIGNAL("javaScriptWindowObjectCleared()"), self, SLOT('evaluateRuby()') )
    
    self.load Qt::Url.new("#{File.dirname(__FILE__)}/../../public/index.html")
    show
  end
  
  private
  
  def evaluateRuby(code)
    puts code
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

