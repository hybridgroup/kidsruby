  def initialize(game_window)
    @game_window = game_window
    @icon = Gosu::Image.new(@game_window, "gosu/asteroid.png", true)
    @x = rand(@game_window.width)
    @y = 0
  end

