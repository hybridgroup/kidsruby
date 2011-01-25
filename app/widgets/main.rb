# this is the main view widget
class MainWidget < Qt::Widget
  q_classinfo("D-Bus Interface", "com.kidsruby.Main")
  
  slots 'alert(const QString&)', 'QString ask(const QString&)'
  
  def initialize(parent = nil)
    super(parent)
    
    Qt::DBusConnection.sessionBus.registerObject("/", self, Qt::DBusConnection::ExportAllSlots)
        
    self.window_title = version_description
    resize(700, 500)
    
    @controls = ControlsWidget.new(self)
    @editor = EditorWidget.new(self)
    
    left_side = Qt::VBoxLayout.new
    left_side.add_widget(@editor, 4)
    left_side.add_widget(@controls, 1)

    @out = OutputWidget.new

    right_side = Qt::VBoxLayout.new
    right_side.add_widget(@out)
    
    self.layout = Qt::HBoxLayout.new do
      add_layout left_side
      add_layout right_side
    end
        
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

