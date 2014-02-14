  def initialize
    super(300, 400, false)
    @player1 = Player.new(self)
    @ball = Ball.new(self)
  end

