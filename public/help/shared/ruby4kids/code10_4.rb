def initialize
  super(600, 400, false)
  @player1 = Player1.new(self)
  @ball = Ball.new(self)
  @pause = false
  @font = Gosu::Font.new(self, 'System', 24)
end
