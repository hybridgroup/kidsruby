# this is the widget with the main controls "Run" etc.
class ControlsWidget < Qt::Widget
  slots :run
  
  def initialize(parent = nil)
    super(parent)
    @main = parent
    
    run_button = Qt::PushButton.new('Run')
    connect(run_button, SIGNAL(:clicked), self, SLOT(:run))

    save_button = Qt::PushButton.new('Save') do
      connect(SIGNAL :clicked) { Qt::Application.instance.quit }
    end

    open_button = Qt::PushButton.new('Open') do
      connect(SIGNAL :clicked) { Qt::Application.instance.quit }
    end

    quit_button = Qt::PushButton.new('Quit') do
      connect(SIGNAL :clicked) { Qt::Application.instance.quit }
    end

    resize(100, 50)

    self.layout = Qt::HBoxLayout.new do
      add_widget(run_button, 0, Qt::AlignCenter)
      add_widget(save_button, 0, Qt::AlignCenter)
      add_widget(open_button, 0, Qt::AlignCenter)
      add_widget(quit_button, 0, Qt::AlignCenter)
    end

    show
  end
  
  def run
    Runner.new(@main).run(@main.current_code)
  end
end
