# this is the editor widget
class EditorWidget < Qt::Widget
  attr_reader :code_editor
  
  def initialize(parent = nil)
    super(parent)
        
    font = Qt::Font.new
    font.family = "Courier"
    font.fixedPitch = true
    font.pointSize = 12

    @code_editor = Qt::TextEdit.new
    @code_editor.font = font
    
    highlighter = RubyHighlighter.new
    highlighter.addToDocument(@code_editor.document())
    
    l = Qt::VBoxLayout.new
    l.add_widget(@code_editor)
    self.layout = l
    
    setSizePolicy(Qt::SizePolicy.new(Qt::SizePolicy::MinimumExpanding, Qt::SizePolicy::MinimumExpanding))
  end
  
  def current_code
    return @code_editor.plainText
  end
end
