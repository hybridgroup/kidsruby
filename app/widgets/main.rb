# this is the main view widget
class MainWidget < Qt::Widget
  def initialize(parent = nil)
    super
    self.window_title = 'Hello KidsRuby v1.0'
    resize(200, 100)

    button = Qt::PushButton.new('Quit') do
        connect(SIGNAL :clicked) { Qt::Application.instance.quit }
    end

    label = Qt::Label.new('<big>Hello Kids Welcome to Ruby!</big>')

    self.layout = Qt::VBoxLayout.new do
        add_widget(label, 0, Qt::AlignCenter)
        add_widget(button, 0, Qt::AlignRight)
    end

    show
  end
end

