# this is the widget with the console output
class OutputWidget < Qt::Widget
  def initialize(parent = nil)
    super(parent)
    
    font = Qt::Font.new
    font.family = "Courier"
    font.fixedPitch = true
    font.pointSize = 12
    
    output = Qt::TextEdit.new
    output.font = font
    output.read_only = true
    output.append "KidsRuby 0.1 output goes here."
    
    self.layout = Qt::VBoxLayout.new do
      add_widget(output)
    end

  end
end
