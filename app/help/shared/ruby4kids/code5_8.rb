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

    if button_down? Gosu::Button::KbRight
      @player1.move_right
    end

    if button_down? Gosu::Button::KbUp
      @player1.move_up
    end

    if button_down? Gosu::Button::KbDown
      @player1.move_down
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
    if @x < 0
      @x = 0
    else
      @x = @x - 10
    end
  end

  def move_right
    if @x > (@game_window.width - 100)
      @x = @game_window.width - 100
    else
      @x = @x + 10
    end
  end

  def move_up 
    if @y < 0
      @y = 0
    else
      @y = @y - 10
    end
  end
 
  def move_down
    if @y > (@game_window.height - 75)
      @y = @game_window.height - 75
    else
      @y = @y + 10
    end
  end
end

window = MyGame.new
window.show


