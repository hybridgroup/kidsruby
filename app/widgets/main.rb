# this is the main view widget
class MainWidget < Qt::Widget
  def initialize(parent = nil)
    super(parent)
    
    self.window_title = 'KidsRuby v' + KidsRuby::VERSION
    resize(700, 500)
    
    controls = ControlsWidget.new
    editor = EditorWidget.new(self)
    
    left_side = Qt::VBoxLayout.new do
      add_widget(editor, 4)
      add_widget(controls, 1)
    end

    output = OutputWidget.new

    right_side = Qt::VBoxLayout.new do
      add_widget(output)
    end
    
    self.layout = Qt::HBoxLayout.new do
      add_layout left_side
      add_layout right_side
    end
        
    show
  end
end

