# this is the main view widget
class MainWidget < Qt::Widget
  #q_classinfo("D-Bus Interface", "com.kidsruby.MainWidget")
  
  slots 'alert(QString)'
  
  def initialize(parent = nil)
    super(parent)
    
    #Qt::DBus.sessionBus().registerObject("/", self, Qt::DBusConnection::ExportSlots)
    
    self.window_title = 'KidsRuby v' + KidsRuby::VERSION
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
    Qt::MessageBox::information(self, tr('KidsRuby v' + KidsRuby::VERSION), text)
  end
end

