require "qtwebkit"

# this is the main view widget
class MainWidget < Qt::WebView
  q_classinfo("D-Bus Interface", "com.kidsruby.Main")

  slots 'evaluateRuby(QString)', 'setupQtBridge()', 'alert(const QString&)', 'QString ask(const QString&)'
    
  def initialize(parent = nil)
    super(parent)
    
    Qt::DBusConnection.sessionBus.registerObject("/", self, Qt::DBusConnection::ExportAllSlots)
        
    self.window_title = version_description
    resize(700, 500)
    
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
  
  def alert(text)
    Qt::MessageBox::information(self, tr(version_description), text)
  end
  
  def ask(text)
    ok = Qt::Boolean.new
    val = Qt::InputDialog.getText(self, tr(version_description),
                                  tr(text), Qt::LineEdit::Normal,
                                  "", ok)
    return val
  end
  
  def version_description
    'KidsRuby v' + KidsRuby::VERSION
  end
end

