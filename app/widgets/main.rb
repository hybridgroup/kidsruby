# this is the main view widget
class MainWidget < Qt::Widget
  def initialize(parent = nil)
    super
    controls = ControlsWidget.new
    editor = EditorWidget.new

    self.layout = Qt::VBoxLayout.new do
      add_widget(editor, 0, Qt::AlignBottom)
      add_widget(controls, 0, Qt::AlignBottom)
    end
    
    show
  end
end

