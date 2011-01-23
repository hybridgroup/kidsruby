# this is the main view widget
class MainWidget < Qt::Widget
  def initialize(parent = nil)
    super(parent)
    
    self.window_title = 'KidsRuby v0.1'
    resize(300, 200)
    
    controls = ControlsWidget.new
    editor = EditorWidget.new(self)
    
    left_side = Qt::VBoxLayout.new do
      add_widget(editor, 0, Qt::AlignTop)
      add_widget(controls, 0, Qt::AlignBottom)
    end

    output = OutputWidget.new

    right_side = Qt::VBoxLayout.new do
      add_widget(output, 0, Qt::AlignTop)
    end
    
    self.layout = Qt::HBoxLayout.new do
      add_layout left_side
      add_layout right_side
    end
    
    show
  end
end

