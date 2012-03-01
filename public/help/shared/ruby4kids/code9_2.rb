def initialize(game_window)
  @game_window = game_window
  @icon = Gosu::Image.new(@game_window, "gosu/player1.png")
  @x = 50
  @y = 330
end
