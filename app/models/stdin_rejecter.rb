class StdinRejecter
  def initialize(widget, delimeter)
    @widget = widget
    @delimeter = delimeter
  end

  def keyPressEvent(event)
    if @delimeter == event.key
      @widget.rejectStdin
    end
  end
end
