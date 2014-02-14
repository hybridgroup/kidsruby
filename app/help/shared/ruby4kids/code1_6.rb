require 'gosu'

class MyGame < Gosu::Window
  def initialize
    super(300, 400, false)
  end

  def update
  end

  def draw
  end
end

window = MyGame.new
window.show
