# this is the main view widget
class MainWidget < Qt::Widget
  def initialize(parent = nil)
    super
    setFixedSize(200, 120)

    quit = Qt::PushButton.new(tr('Quit'), self)
    quit.setGeometry(62, 40, 75, 30)
    quit.setFont(Qt::Font.new('Times', 18, Qt::Font::Bold))

    connect(quit, SIGNAL('clicked()'), $qApp, SLOT('quit()'))
  end
end

