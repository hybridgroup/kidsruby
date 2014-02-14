def draw
  @player1.draw
  @balls.each {|ball| ball.draw}
end
