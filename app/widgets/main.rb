# this is the main view widget
class MainWidget < Qt::Widget
  def initialize(parent = nil)
    super(parent)
    
    self.window_title = 'KidsRuby v0.1'
    resize(300, 200)
    
    controls = ControlsWidget.new
    editor = EditorWidget.new(self)

    self.layout = Qt::VBoxLayout.new do
      add_widget(editor, 0, Qt::AlignTop)
      add_widget(controls, 0, Qt::AlignBottom)
    end
    
    show
  end
end

