require 'gosu'

class MyGame < Gosu::Window
  def initialize
    super(600, 400, false)
    @player1 = Player.new(self)
    @balls = 3.times.map {Ball.new(self)}
    @running = true
  end

  def update
    if @running
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

      @balls.each {|ball| ball.update}

      if @player1.hit_by? @balls
        stop_game!
      end
    else
      #the game is currently stopped
      if button_down? Gosu::Button::KbEscape
        restart_game
      end
    end
  end

  def draw
    @player1.draw
    @balls.each {|ball| ball.draw}
  end

  def stop_game!
    @running = false
  end

  def restart_game
    @running = true
    @balls.each {|ball| ball.reset!}
  end
end

class Player
  def initialize(game_window)
    @game_window = game_window
    @icon = Gosu::Image.new(@game_window, "gosu/player1.png", true)
    @x = 150
    @y = 330
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

  def hit_by?(balls)
   balls.any? {|ball| Gosu::distance(@x, @y, ball.x, ball.y) < 50}
  end
end

class Ball
  def initialize(game_window)
    @game_window = game_window
    @icon = Gosu::Image.new(@game_window, "gosu/asteroid.png", true)
    reset!
  end

  def update
    if @y > @game_window.height
      reset!
    else
      @y = @y + 10
    end
  end

  def draw
    @icon.draw(@x,@y,2)
  end

  def x
    @x
  end
 
  def y
    @y
  end

  def reset!
    @y = 0
    @x = rand(@game_window.width)
  end

end

window = MyGame.new
window.show
