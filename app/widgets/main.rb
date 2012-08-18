require "qtwebkit"
require 'htmlentities'
require_relative '../models/inverts_theme.rb'

# this is the main view widget
class MainWidget < Qt::WebView
  include InvertsTheme
  default_theme "ace/theme/merbivore"
  alternate_theme "ace/theme/clouds"

  signals 'stdInRequested()'
  slots 'rejectStdin()', 'acceptStdin()', 'QString language()', 'QStringList languages()',
        'evaluateRuby(QString)', 'stopRuby()', 'runnerFinished(int, QProcess::ExitStatus)',
        'setupQtBridge()', 'openRubyFile(const QString&)', 'saveRubyFile(const QString&)',
        'QString gets()', 'alert(const QString&)', 'QString ask(const QString&)',
        'append(const QString&)', 'appendError(const QString&)'

  def initialize
    super

    @turtle = TurtleInterface.new(self)
    @server = KidsRubyServer.new(self, @turtle)

    self.window_title = version_description
    resize(@@app.desktop.width, @@app.desktop.height * 0.9)
    move(0,0)
    showMaximized()

    @frame = self.page.mainFrame
    @runner = Runner.new(self)

    @coder = HTMLEntities.new

    settings.setAttribute(Qt::WebSettings::LocalContentCanAccessRemoteUrls, true)

    Qt::Object.connect(@frame,  SIGNAL("javaScriptWindowObjectCleared()"), 
                          self, SLOT('setupQtBridge()'))
    initialize_stdin_connection
    self.load Qt::Url.new(File.expand_path(File.dirname(__FILE__) + "/../../public/index.html"))
    show
  end

  protected

  def set_theme(theme)
    @frame.evaluateJavaScript("window.editor.setTheme('#{theme}')")
  end

  def version_description
    'KidsRuby v' + KidsRuby::VERSION
  end

  def keyPressEvent(event)
    return false if event.key == Qt::Key_Escape
    notify_stdin_event_listeners(event) if @acceptStdin
    super
  end

  private

  def language
    KidsRuby::Language.current
  end

  def languages
    KidsRuby::Language.supported
  end

  def initialize_stdin_connection
    Qt::Object.connect(self, SIGNAL("stdInRequested()"), 
                          self, SLOT('acceptStdin()'))
    rejectStdin
  end

  def notify_stdin_event_listeners(event)
    (@frame_writer  ||= FrameWriter.new(@frame)).keyPressEvent(event)
    (@runner_writer ||= RunnerWriter.new(@runner)).keyPressEvent(event)
    @stdInRejecter.keyPressEvent(event) if @stdInRejecter
  end

  def acceptStdin
    @acceptStdin = true
    @frame.evaluateJavaScript('acceptStdIn();')
  end

  def rejectStdin
    @acceptStdin = false
  end

  def setupQtBridge
    @frame.addToJavaScriptWindowObject("QTApi", self);
  end

  def evaluateRuby(code)
    @frame.evaluateJavaScript("setRunButtonToStop();")
    @runner.run(code)
  end

  def stopRuby
    @runner.stop
    @frame.evaluateJavaScript("updateStdOut('STOPPED.<br/>');")
  end

  def runnerFinished(code, status)
    @frame.evaluateJavaScript("setStopButtonToRun();")
  end

  def openRubyFile(nada)
    fileName = Qt::FileDialog.getOpenFileName(self,
                                tr("Open a Ruby File"),
                                "",
                                tr("Ruby Files (*.rb)"))
    unless fileName.nil?
      codeFile = Qt::File.new(fileName)
      unless codeFile.open(Qt::File::ReadOnly | Qt::File::Text)
          Qt::MessageBox::warning(self, tr("KidsRuby Problem"),
                                 tr("Oh, uh! Cannot open file %s:\n%s" %
                                 [ codeFile.fileName(), codeFile.errorString() ] ) )
          return
      end
      @frame.evaluateJavaScript("clearCode();")

      inf = Qt::TextStream.new(codeFile)

      while !inf.atEnd()
        line = escape_for_open(inf.readLine())
        line.force_encoding("UTF-8")
        @frame.evaluateJavaScript("addCode('#{line}');")
      end
    end
  end

  def saveRubyFile(code)
    fileName = Qt::FileDialog.getSaveFileName(self, tr("Save Ruby Code"), tr(".rb"))
	  unless fileName.nil?
	    file = Qt::File.new(fileName)
	    unless file.open(Qt::File::WriteOnly | Qt::File::Text)
	        Qt::MessageBox::warning(self, tr("KidsRuby Problem"),
	                             tr("Cannot write file %s:\n%s." % [fileName, file.errorString]))
	        return
	    end

	    outf = Qt::TextStream.new(file)
	    code.force_encoding("UTF-8")
	    outf << code
	    outf.flush
	  end
  end

  JS_ESCAPE_MAP = {
        '\\'    => '\\\\',
        '</'    => '<\/',
        "\r\n"  => '\n',
        "\n"    => '\n',
        "\r"    => '\n',
        '"'     => '\\"',
        "'"     => "\\'" }

  def escape_for_open(text)
    if text
      text.gsub(/(\\|<\/|\r\n|[\n\r"'])/) { JS_ESCAPE_MAP[$1] }
    else
      ''
    end
  end

  def append(text)
    t = text.gsub(/\n/,"<br/>")
    @frame.evaluateJavaScript("updateStdOut('#{@coder.encode(t)}')")
  end

  def appendError(text)
    t = text.gsub(/\n/,"<br/>")
    @frame.evaluateJavaScript("updateStdErr('#{@coder.encode(t)}')")
  end

  def current_code
    @editor.current_code
  end

  def current_output
    @out
  end

  def alert(text)
    Qt::MessageBox::information(self, tr(version_description), URI.decode(text))
  end

  def ask(text)
    ok = Qt::Boolean.new
    val = Qt::InputDialog.getText(self, tr(version_description),
                                  URI.decode(text), Qt::LineEdit::Normal,
                                  "", ok)
    return val
  end

  def gets
    @stdInRejecter = StdinRejecter.new(self, Qt::Key_Return) 
    emit stdInRequested()
  end
end
