class Ball
  def initialize(game_window)
    @game_window = game_window
    @icon = Gosu::Image.new(@game_window, "gosu/asteroid.png")
    reset!
  end
end

def update 
  if @y > @gamewindow.height
    reset!
  else
    @y = @y + 10
  end
end
