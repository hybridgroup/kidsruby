def initialize(game_window)
    @game_window = game_window
    @icon = Gosu::Image.new(@game_window, "images/ball.png", true)
    @x = 50
    @y = 150

