require "qtwebkit"

# this is the main view widget
class MainWidget < Qt::WebView
  q_classinfo("D-Bus Interface", "com.kidsruby.Main")

  slots 'evaluateRuby(QString)', 'setupQtBridge()', 'alert(const QString&)', 'QString ask(const QString&)', 'openRubyFile(const QString&)', 'saveRubyFile(const QString&)'
    
  def initialize(parent = nil)
    super(parent)
    
    Qt::DBusConnection.sessionBus.registerObject("/", self, Qt::DBusConnection::ExportAllSlots)
    
    @turtle = TurtleInterface.new(self)
    
    self.window_title = version_description
    resize(1000, 700)
    
    @frame = self.page.mainFrame
    
    Qt::Object.connect(@frame,  SIGNAL("javaScriptWindowObjectCleared()"), self, SLOT('setupQtBridge()') )

    self.load Qt::Url.new(File.expand_path(File.dirname(__FILE__) + "/../../public/index.html"))
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
  
  def openRubyFile(nada)
    fileName = Qt::FileDialog.getOpenFileName(self,
                                tr("Open a Ruby File"),
                                "",
                                tr("Ruby Files (*.rb)"))
    unless fileName.nil?
      codeFile = Qt::File.new(fileName)
      unless codeFile.open(Qt::File::ReadOnly | Qt::File::Text)
          Qt::MessageBox.warning(self, tr("KidsRuby Problem"),
                                 tr("Oh, uh! Cannot open file %s:\n%s" %
                                 [ codeFile.fileName(), codeFile.errorString() ] ) )
          return
      end
      @frame.evaluateJavaScript("clearCode();")

      inf = Qt::TextStream.new(codeFile)

      while !inf.atEnd()
        line = inf.readLine()
        @frame.evaluateJavaScript("addCode('#{line}');")
      end
    end
  end

  def saveRubyFile(code)
    fileName = Qt::FileDialog.getSaveFileName(self, tr("Save Ruby Code"), tr(".rb"))
	  unless fileName.nil?
	    file = Qt::File.new(fileName)
	    unless file.open(Qt::File::WriteOnly | Qt::File::Text)
	        Qt::MessageBox.warning(self, tr("KidsRuby Problem"),
	                             tr("Cannot write file %s:\n%s." % [fileName, file.errorString]))
	        return
	    end

	    outf = Qt::TextStream.new(file)
	    outf << code
	    outf.flush
	  end
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

