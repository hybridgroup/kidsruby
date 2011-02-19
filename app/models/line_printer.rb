class LinePrinter
  attr_reader :line

  def initialize(frame, device)
    @frame = frame
    @device = device
  end

  def line
    @line ||= init_stdin_line
  end

  def init_stdin_line
    @frame.evaluateJavaScript("initStdInLine()"); 
    @line = String.new
  end

  def <<(string)
    line << string
  end

  def print
    @frame.evaluateJavaScript("cutStdInToStdOut()")
    full_line = "#{line}\n"
    @device.write(full_line)
    full_line
  end

  def delete_last
    line_but_last_char = line[0..-2]
    @frame.evaluateJavaScript("replaceStdIn('#{line}', '#{line_but_last_char}')")
    @line = line_but_last_char
  end

  def clear
    @line = nil
  end
end
