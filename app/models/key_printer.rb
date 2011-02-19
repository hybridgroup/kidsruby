class KeyPrinter < Qt::Object
  signals 'returnPrinted()'

  def initialize(main, device)
    super(main)

    @frame  = main.page.main_frame
    @device = device
    @lp = LinePrinter.new(main, device)
  end

  def print(event)
    @event = event
    case @event.key
    when Qt::Key_Return then handle_return_keypress
    when Qt::Key_Backspace then handle_backspace_keypress
    else handle_keypress end
  end

  def handle_return_keypress
    @lp.print
    @lp.clear
    emit returnPrinted()
  end

  def handle_keypress
    @frame.evaluateJavaScript("updateStdIn('#{@event.text}')")
    @lp << @event.text
  end

  def handle_backspace_keypress
    @lp.delete_last
  end
end
