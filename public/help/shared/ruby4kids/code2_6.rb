require 'gosu'

class MyGame < Gosu::Window
  def initialize
    super(300, 400, false)
    @player1 = Player.new(self)
  end

  def update
  end

  def draw
    @player1.draw
  end
end

class Player
  def initialize(game_window)
    @game_window = game_window
    @icon = Gosu::Image.new(@game_window, "gosu/player1.png", true)
  end

  def draw
    @icon.draw(50, 50, 1)
  end
end

window = MyGame.new
window.show
