# this is the clss that actually does the color mapping.
# TODO: make it work correctly for Ruby syntax, this is just an example...
class RubyHighlighter < Highlighter
  def initialize(parent = nil)
    super(parent)
    
    variableFormat = Qt::TextCharFormat.new
    variableFormat.fontWeight = Qt::Font::Bold
    variableFormat.foreground = Qt::Brush.new(Qt::blue)
    addMapping('\b[A-Z_]+\b', variableFormat)

    singleLineCommentFormat = Qt::TextCharFormat.new
    singleLineCommentFormat.background = Qt::Brush.new(Qt::Color.new("#77ff77"))
    addMapping('#[^\n]*', singleLineCommentFormat)

    quotationFormat = Qt::TextCharFormat.new
    quotationFormat.background = Qt::Brush.new(Qt::cyan)
    quotationFormat.foreground = Qt::Brush.new(Qt::blue)
    addMapping('\".*\"', quotationFormat)

    functionFormat = Qt::TextCharFormat.new
    functionFormat.fontItalic = true
    functionFormat.foreground = Qt::Brush.new(Qt::blue)
    addMapping('\b[a-z0-9_]+\(.*\)', functionFormat)
  end
end