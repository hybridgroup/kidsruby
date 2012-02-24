require 'gosu'

class MyGame < Gosu::Window
  def initialize
    super(300, 400, false)
    @player1 = Player.new(self)
  end

  def update
    if button_down? Gosu::Button::KbLeft
      @player1.move_left
    end
  end

  def draw
    @player1.draw
  end
end

class Player
  def initialize(game_window)
    @game_window = game_window
    @icon = Gosu::Image.new(@game_window, "gosu/player1.png", true)
    @x = 50
    @y = 50
  end

  def draw
    @icon.draw(@x,@y,1)
  end

  def move_left
    @x = @x - 10
  end
end

window = MyGame.new
window.show
