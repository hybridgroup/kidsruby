class FrameWriter
  def initialize(frame)
    @frame = frame
  end

  def keyPressEvent(event)
    case event.key
    when Qt::Key_Return
      @frame.evaluateJavaScript("cutStdInToStdOut();")
      @frame.evaluateJavaScript("updateStdOut('<br/>');")
      @frame.evaluateJavaScript("removeCursor();")
    when Qt::Key_Backspace
      @frame.evaluateJavaScript("deleteLastStdIn();")
    else
      @frame.evaluateJavaScript("updateStdIn('#{event.text}');")
    end
  end
end
