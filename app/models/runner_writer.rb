class RunnerWriter
  attr_reader :line

  def initialize(runner)
    @runner = runner
    @line = String.new
  end

  def keyPressEvent(event)
    case event.key
    when Qt::Key_Return
      @line << "\n"
      @runner.write(@line)
      @line = ""
    when Qt::Key_Backspace
      @line = @line[0..-2]
    else
      @line << event.text if event.text
    end
  end
end
