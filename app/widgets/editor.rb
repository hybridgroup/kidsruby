# this is the editor widget
class EditorWidget < Qt::Widget
  def initialize(parent = nil)
    super(parent)
        
    font = Qt::Font.new
    font.family = "Courier"
    font.fixedPitch = true
    font.pointSize = 12

    editor = Qt::TextEdit.new
    editor.font = font
    
    highlighter = RubyHighlighter.new
    highlighter.addToDocument(editor.document())
    
    self.layout = Qt::VBoxLayout.new do
      add_widget(editor, 0, Qt::AlignBottom)
    end
    
    show
  end
end
