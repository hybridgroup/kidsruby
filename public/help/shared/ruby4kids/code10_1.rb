def initialize
  super(300, 300, false)
  @player1 = Player.new(self)
  @ball = Ball.new(self)
  @pause = false
end
