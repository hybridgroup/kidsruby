# this is the widget with the main controls "Run" etc.
class ControlsWidget < Qt::Widget
  def initialize(parent = nil)
    super(parent)
    
    run_button = Qt::PushButton.new('Run') do
      #connect(SIGNAL :clicked) { Qt::Application.instance.quit }
    end

    save_button = Qt::PushButton.new('Save') do
      connect(SIGNAL :clicked) { Qt::Application.instance.quit }
    end

    open_button = Qt::PushButton.new('Open') do
      connect(SIGNAL :clicked) { Qt::Application.instance.quit }
    end

    quit_button = Qt::PushButton.new('Quit') do
      connect(SIGNAL :clicked) { Qt::Application.instance.quit }
    end

    resize(100, 200)

    self.layout = Qt::HBoxLayout.new do
      add_widget(run_button, 0, Qt::AlignCenter)
      add_widget(save_button, 0, Qt::AlignCenter)
      add_widget(open_button, 0, Qt::AlignCenter)
      add_widget(quit_button, 0, Qt::AlignCenter)
    end

    show
  end
end
