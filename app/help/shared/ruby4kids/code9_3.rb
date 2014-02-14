def initialize
  super(600, 400, false)
  @player1 = Player.new(self)
  @balls = 3.times.map {Ball.new(self)}
  @running = true
end
